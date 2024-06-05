class PokemonsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_collection_and_album
  before_action :load_collection_and_album, only: [:new, :create]
  # Recherche les Pokémon par leur nom
  def new
    load_collection_and_album
    @seasons = Season.all
    @pokemons = Pokemon.where("pokemon_name ILIKE ? OR pokemon_id ILIKE ?", "%#{params[:name]}%", "%#{params[:name]}%") if params[:name].present?
  end

  # Crée un nouveau Pokémon dans l'album spécifié
  def create
    load_collection_and_album
    @pokemon = Pokemon.find(params[:pokemon_id])
    @album_pokemon = AlbumPokemon.new(album: @album, pokemon: @pokemon)
    @album_pokemon.save ? redirect_to(album_pokemons_path(@album), notice: 'Pokemon ajouté avec succès.') : render(:new)
  end

  private

  # Charge la collection et l'album
  def load_collection_and_album
    @album = Album.find(params[:album_id])
    @collection = @album.collection
    end
end
