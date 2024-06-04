class Collection < ApplicationRecord
  belongs_to :user
  has_many :albums, dependent: :destroy

  validates :name, presence: true
end
