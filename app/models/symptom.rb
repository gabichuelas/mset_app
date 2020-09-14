class Symptom < ApplicationRecord
  validates :description, presence: true

  # has_many :medication_symptoms
  # has_many :medications, through: :medication_symptoms
  has_many :logs
end
