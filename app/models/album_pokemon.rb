class AlbumPokemon < ApplicationRecord
  belongs_to :album
  belongs_to :pokemon
end
