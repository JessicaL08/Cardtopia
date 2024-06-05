class AlbumsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection, only: [:index, :new, :create]
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  def index
    @albums = @collection.albums
  end

  def show
    @pokemons = @album.pokemons
  end

  def new
    @album = @collection.albums.build
  end

  def create
    @album = @collection.albums.build(album_params)
    if @album.save
      redirect_to collection_album_path(@collection, @album), notice: 'Album created successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @album.update(album_params)
      redirect_to collection_album_path(@collection, @album), notice: 'Album updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @album.destroy
    redirect_to collection_albums_path(@collection), notice: 'Album deleted successfully.'
  end

  private

  def set_collection
    @collection = @album.collection
    # @collection = Collection.find(params[:collection_id])
  end

  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:name)
  end
end
