class Collection < ApplicationRecord
  belongs_to :user
  has_many :albums, dependent: :destroy
  has_many :pokemons, through: :albums

  validates :name, presence: true
end
