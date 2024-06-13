class Pokemon < ApplicationRecord
  has_many :album_pokemons
  has_many :albums, through: :album_pokemons
  belongs_to :extension
  has_one :season, through: :extension

  validates :pokemon_name, presence: true

  TYPES = [:fire, :water, :grass, :electric, :normal, :fighting, :steel, :psychic, :dragon, :dark, :fairy]

  def self.with_extension_and_season
    joins(extension: :season)
      .select('pokemons.*, extensions.extension_name, seasons.season_name')
  end

  def pokemon_type
    type = self.metadata['types']&.first || 'unknown'
    I18n.t("pokemon_types").key(type)
  end

  def icon_type_src(type)
    type_en = I18n.t("pokemon_types").key(type)
    "energy/#{type_en}.png"
  end
  # I18n : call the function to translate
  # .t('value') : to have the specific method into the function
  # .key('param') : to have the translation of the specific parameter
end
