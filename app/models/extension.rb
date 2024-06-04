class Extension < ApplicationRecord
  belongs_to :season
  has_many :pokemons

  validates :extension_name, presence: true
  validates :extension_acronym, presence: true
end
