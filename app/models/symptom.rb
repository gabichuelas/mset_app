class Symptom < ApplicationRecord
  validates :description, presence: true

  has_many :medication_symptoms
  has_many :medications, through: :medication_symptoms
  has_many :logs

  def self.potential_symptoms(user)
    joins(medications: [:medication_symptoms, :user_medications]).where("user_medications.user_id=#{user.id}").distinct
  end
end
