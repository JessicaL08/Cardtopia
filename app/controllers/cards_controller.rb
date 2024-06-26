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
      redirect_to collection_album_path(@collection, @album), notice: 'Cartes créés avec succès.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @card.update(card_params)
      redirect_to collection_album_path(@collection, @album), notice: 'Cartes mises à jour avec succès.'
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to collection_album_path(@collection, @album), notice: 'Cartes supprimés avec succès.'
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
