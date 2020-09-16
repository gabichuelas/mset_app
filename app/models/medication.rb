class Medication < ApplicationRecord
  validates :brand_name, :product_ndc, presence: true

  has_many :medication_symptoms, dependent: :destroy
  has_many :symptoms, through: :medication_symptoms
  has_many :user_medications, dependent: :destroy
end 
