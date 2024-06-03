class Season < ApplicationRecord
  has_many :extensions
  has_many :pokemons, through: :extensions
end
