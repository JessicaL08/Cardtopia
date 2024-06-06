class ExchangeRequest < ApplicationRecord
  belongs_to :user
  belongs_to :pokemon

  validates :postal_code, presence: true
end
