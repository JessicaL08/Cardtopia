class Season < ApplicationRecord
  has_many :extensions

  validates :season_name, presence: true
  validates :season_acronym, presence: true
end
