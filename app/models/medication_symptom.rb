class MedicationSymptom < ApplicationRecord
  validates :medication_id, :symptom_id

  belongs_to :medication
  belongs_to :symptom
end
