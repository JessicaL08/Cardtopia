class Album < ApplicationRecord
  belongs_to :collection
  # has_many :album_pokemons
  has_many :album_pokemons, dependent: :destroy
  has_many :pokemons, through: :album_pokemons

  validates :name, presence: true
end
