class Extension < ApplicationRecord
  belongs_to :season
  has_many :pokemons
end
