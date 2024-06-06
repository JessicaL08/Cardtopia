class AlbumPokemonsController < ApplicationController

  def new
    load_collection_and_album
    @seasons = Season.includes(:extensions).all
    # find extension if user click on button season
    @extensions = Extension.where("season_id = ?", params[:season_id]) if params[:season_id].present?
    if params[:extension_id].present?
      # find pokemon where user click on button extension
      @pokemons = Pokemon.where("extension_id = ?", params[:extension_id])
    elsif params[:name].present?
# find pokemon where user put name or
      @pokemons = Pokemon.where("pokemon_name ILIKE ? OR pokemon_id ILIKE ?", "%#{params[:name]}%", "%#{params[:name]}%")
    end
  end

  def create
    @album = Album.find(params[:album_id])
    @pokemon = Pokemon.find(params[:pokemon_id])
    @album_pokemon = AlbumPokemon.new(album: @album, pokemon: @pokemon)
    @album_pokemon.save ? redirect_to(album_path(@album), notice: 'Pokemon ajouté avec succès.') : render(:new)
  end

  private

  def load_collection_and_album
    @album = Album.find(params[:album_id])
    @collection = @album.collection
  end
end
