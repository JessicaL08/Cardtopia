class Pokemon < ApplicationRecord
  has_many :album_pokemons
  has_many :albums, through: :album_pokemons

  validates :pokemon_name, presence: true

  def self.with_extension_and_season
    joins(extension: :season)
      .select('pokemons.*, extensions.extension_name, seasons.season_name')
  end
end
