class AlbumPokemonsController < ApplicationController

  def new
    load_collection_and_album
    @seasons = Season.all
    @pokemons = Pokemon.where("pokemon_name ILIKE ? OR pokemon_id ILIKE ?", "%#{params[:name]}%", "%#{params[:name]}%") if params[:name].present?
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
