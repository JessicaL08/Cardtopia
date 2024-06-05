class PokemonsController < ApplicationController

   def show
    @pokemon = Pokemon.find(params[:album_pokemon_id])
   end

end
