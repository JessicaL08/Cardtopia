class PokemonsController < ApplicationController
  def show

    # @pokemon = Pokemon.includes(name:).find(params[:album_pokemon_id])
    @pokemon = Pokemon.find(params[:album_pokemon_id])
    @album = Album.find(params[:album_id])
    # order pokemons
    pokemons = @album.pokemons
    first_part = pokemons.slice(0, pokemons.index(@pokemon))
    second_part = pokemons.slice(pokemons.index(@pokemon), pokemons.count)
    @reordered_pokemons = second_part.concat(first_part)

    respond_to do |format|
      format.html
      format.json { render json: @pokemon }
    end
  end

  def render_content
    @pokemon = Pokemon.find(params[:id])
    render json: {
      partial: render_to_string(
        partial: "pokemons/pokemon_content",
        locals: { pokemon: @pokemon },
        formats: [:html],
      ),
    }
  end

  def search
    @pokemon_names = Pokemon.where("pokemon_name ILIKE ?", "%#{params[:name]}%").map(&:pokemon_name).uniq

    render json: {
      partial: render_to_string(
        partial: "shared/pokemon_names",
        locals: { pokemon_names: @pokemon_names },
        formats: [:html],
      ),
    }
  end
end
