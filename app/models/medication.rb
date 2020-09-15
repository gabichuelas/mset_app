class Medication < ApplicationRecord
  validates :brand_name, :product_ndc, presence: true

  has_many :medication_symptoms, dependent: :destroy
  has_many :symptoms, through: :medication_symptoms
  has_many :user_medications, dependent: :destroy

  def save_symptoms
    symptoms = get_symptoms
    if !symptoms.nil?
      symptoms.each do |symptom|
        new_sym = Symptom.find_or_create_by(description: symptom)
        MedicationSymptom.create(medication_id: self.id, symptom_id: new_sym.id)
      end
    end
  end

  def get_symptoms
    SearchResultsFacade.new.extract_symptoms(self.product_ndc)
  end
end
