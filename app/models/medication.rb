class Medication < ApplicationRecord
  validates :brand_name, :generic_name, :product_ndc, presence: true

  has_many :user_medications
  has_many :users, through: :user_medications
end
