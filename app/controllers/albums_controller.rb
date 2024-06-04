class AlbumsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  def index
    @albums = @collection.albums
  end

  def show
    @user = current_user
    @collection = Collection.find(params[:collection_id])
    @album = Album.find(params[:id])
    @pokemons = @album.pokemons
  end

  def new
    @user = current_user
    @collection = Collection.find(params[:collection_id])
    @album = @collection.albums.build
  end

  def create
    @album = @collection.albums.build(album_params)
    if @album.save
      redirect_to user_collection_album_path(current_user, @collection, @album), notice: 'Album created successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @album.update(album_params)
      redirect_to user_collection_album_path(current_user, @collection, @album), notice: 'Album updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @album.destroy
    redirect_to user_collection_albums_path(current_user, @collection), notice: 'Album deleted successfully.'
  end

  private

  def set_collection
    @collection = Collection.find(params[:collection_id])
  end

  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:name)
  end
end
