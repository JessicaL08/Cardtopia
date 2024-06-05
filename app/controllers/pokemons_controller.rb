require 'pry-byebug'

class PokemonsController < ApplicationController
  # Recherche les Pokémon par leur nom

  # Affiche le formulaire pour ajouter un nouveau Pokémon
  def new
    @user = current_user
    @collection = Collection.find(params[:collection_id])
    @album = Album.find(params[:album_id])
    @seasons = Season.all

    if params[:name].present?
      @pokemons = Pokemon.where("pokemon_name ILIKE ? OR pokemon_id ILIKE ?", "%#{params[:name]}%", "%#{params[:name]}%")
    else
      @pokemons = []
    end

  end


  # Crée un nouveau Pokémon dans l'album spécifié
  def create
    @user = current_user
    @collection = Collection.find(params[:collection_id])
    @album = Album.find(params[:album_id])
    @pokemon = Pokemon.find(params[:pokemon_id])
    @album_pokemon = AlbumPokemon.new(album: @album, pokemon: @pokemon)
    if @album_pokemon.save
      redirect_to user_collection_album_path(@user, @collection, @album), notice: 'Pokemon ajouté avec succès.'
    else
      render :new
    end
  end

  def show

  end

  private

  # Définit les paramètres autorisés pour la création d'un Pokémon
  def pokemon_params
    params.require(:pokemon).permit(:name, :type, :level, :ability)
  end
end
