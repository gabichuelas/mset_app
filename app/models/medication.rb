class Medication < ApplicationRecord
  validates :brand_name, :generic_name, :med_id, presence: true

  has_many :user_medications
  has_many :users, through: :user_medications
end
