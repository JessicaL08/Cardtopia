class Album < ApplicationRecord
  belongs_to :collection
  # has_many :album_pokemons
  has_many :album_pokemons, dependent: :destroy
  has_many :pokemons, through: :album_pokemons

  validates :name, presence: true

  def getPokemonImg(index)
    if self.pokemons[index].present?
      self.pokemons[index].image
    else
      "card-back.jpg"
    end
  end

  def pokecardcount
    if self.pokemons.size <= 1
      "carte"
    else
      "cartes"
    end
  end
end
