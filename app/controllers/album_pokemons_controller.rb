class AlbumPokemonsController < ApplicationController
  before_action :set_album
  before_action :set_new_page_flag, only: [:new]

  def new
    load_collection_and_album
    @seasons = Season.includes(:extensions).all
    # find extension if user click on button season
    @extensions = Extension.where("season_id = ?", params[:season_id]) if params[:season_id].present?
    search_pokemon
  end

  def create
    @album_pokemon = @album.album_pokemons.build(pokemon_id: params[:pokemon_id])
    if @album_pokemon.save
      render json: { success: true }
    else
      render json: { success: false, error: @album_pokemon.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def destroy_multiple
    pokemon_ids = params[:pokemon_ids].split(',')
    AlbumPokemon.where(pokemon_id: pokemon_ids).destroy_all
    head :no_content
  end

  private

  def load_collection_and_album
    @album = Album.find(params[:album_id])
    @collection = @album.collection
  end

  def search_pokemon
    if params[:type].present? && params[:extension_id].present?
      @pokemons = Pokemon.where("extension_id = ?", params[:extension_id])
      @pokemons = @pokemons.where("metadata @> ?", { types: [I18n.t("pokemon_types.#{params[:type]}")] }.to_json)
    elsif params[:extension_id].present?
      # find pokemon where user click on button extension
      @pokemons = Pokemon.where("extension_id = ?", params[:extension_id])
    elsif params[:name].present?
    # find pokemon where user put name
      @pokemons = Pokemon.where("unaccent(pokemons.pokemon_name) ILIKE ? OR unaccent(pokemons.pokemon_id) ILIKE ?", "%#{params[:name]}%", "%#{params[:name]}%")
    end
  end

  def set_album
    @album = Album.find_by(id: params[:album_id])
  end

  def set_new_page_flag
    @is_new_page = true
  end
end
