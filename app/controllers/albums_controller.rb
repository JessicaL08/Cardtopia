class AlbumsController < ApplicationController
  before_action :authenticate_user! # Authentifie l'utilisateur avant d'accéder à toute action
  before_action :set_collection, only: [:index, :new, :create] # Définit la collection avant les actions index, new, create
  before_action :set_album, only: [:show, :edit, :update, :destroy] # Définit l'album avant les actions show, edit, update, destroy

  def index
    @albums = @collection.albums # Récupère tous les albums de la collection spécifiée
  end

  def show
    @seasons = Season.includes(:extensions).all
    @extensions = Extension.where("season_id = ?", params[:season_id]) if params[:season_id].present?
    @pokemons = @album.pokemons # Récupère tous les Pokémon associés à l'album spécifique
    search_pokemon
  end

  def new
    @album = @collection.albums.build # Initialise un nouvel album associé à la collection
  end

  def create
    @collection = Collection.find(params[:collection_id]) # Trouve la collection spécifiée dans les paramètres de la requête

    @album = Album.new(album_params)
    @album.collection = @collection
    if @album.save
      redirect_to album_path(@album), notice: 'Album créé avec succès.' # Redirige vers la page de l'album créé
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @album.update(album_params)
      redirect_to album_path(@album), notice: 'Album updated successfully.' # Redirige vers la page de l'album mis à jour
    else
      render :edit # Affiche à nouveau le formulaire d'édition de l'album en cas d'échec
    end
  end

def destroy
  @album.destroy
  redirect_to collection_path(@album.collection), notice: 'Album deleted successfully.'
end

  private

  def set_collection
    @collection = Collection.find(params[:collection_id]) # Trouve la collection spécifiée dans les paramètres de la requête
  end

  def set_album
    @album = Album.find(params[:id]) # Trouve l'album spécifié dans les paramètres de la requête
  end

  def album_params
    params.require(:album).permit(:name) # Autorise uniquement le paramètre :name pour la création ou la mise à jour d'un album
  end

  def search_pokemon

    
    if params[:type].present? && params[:extension_id].present?
      @pokemons = @pokemons.where("extension_id = ?", params[:extension_id])
      @pokemons = @pokemons.where("metadata @> ?", { types: [I18n.t("pokemon_types.#{params[:type]}")] }.to_json)
    elsif
      params[:extension_id].present?
      # find pokemon where user click on button extension
      @pokemons = @pokemons.where("pokemons.extension_id = ?", params[:extension_id])
    elsif params[:name].present?
      # find pokemon where user put name
      @pokemons = @pokemons.where("pokemons.pokemon_name ILIKE ? OR pokemons.pokemon_id ILIKE ?", "%#{params[:name]}%", "%#{params[:name]}%")
    elsif params[:type].present?
      @pokemons = @pokemons.where("metadata @> ?", { types: [I18n.t("pokemon_types.#{params[:type]}")] }.to_json)
    end
  end
end
