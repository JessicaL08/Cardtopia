class PokemonsController < ApplicationController

  def show
    # @pokemon = Pokemon.includes(name:).find(params[:album_pokemon_id])
    @pokemon = Pokemon.find(params[:album_pokemon_id])
    @album = Album.find(params[:album_id])
  end
end
