class Pokemon < ApplicationRecord
  belongs_to :extension
  has_many :album_pokemons
  has_many :albums, through: :album_pokemons
end
