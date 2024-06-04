class Pokemon < ApplicationRecord
  has_many :album_pokemons
  has_many :albums, through: :album_pokemons

  validates :pokemon_name, presence: true
end
