class CreateMedicationSymptoms < ActiveRecord::Migration[5.2]
  def change
    create_table :medication_symptoms do |t|
      t.references :medication, foreign_key: true
      t.references :symptom, foreign_key: true

      t.timestamps
    end
  end
end
