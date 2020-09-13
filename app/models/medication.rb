class Medication < ApplicationRecord
  validates :brand_name, :product_ndc, presence: true

  has_many :user_medications
  has_many :users, through: :user_medications

  def save_symptoms(symptoms)
    symptoms.each do |symptom|
      new_sym = Symptom.create(description: symptom)
      MedicationSymptom.create(medication_id: self.id, symptom_id: new_sym.id)
    end
  end
end
