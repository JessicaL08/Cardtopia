class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection
  before_action :set_album
  before_action :set_card, only: [:edit, :update, :destroy]

  def new
    @card = @album.cards.build
  end

  def create
    @card = @album.cards.build(card_params)
    if @card.save
      redirect_to user_collection_album_path(current_user, @collection, @album), notice: 'Card created successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @card.update(card_params)
      redirect_to user_collection_album_path(current_user, @collection, @album), notice: 'Card updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to user_collection_album_path(current_user, @collection, @album), notice: 'Card deleted successfully.'
  end

  private

  def set_collection
    @collection = current_user.collections.find(params[:collection_id])
  end

  def set_album
    @album = @collection.albums.find(params[:album_id])
  end

  def set_card
    @card = @album.cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:name, :pokemon_id, :image_url)
  end
end
