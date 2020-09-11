class MedicationSymptom < ApplicationRecord
  validates :medication_id, :symptom_id, presence: true

  belongs_to :medication
  belongs_to :symptom
end
