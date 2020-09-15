RSpec.describe Log do
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :symptom_id }

  it { should belong_to :user }
  it { should belong_to :symptom }

  describe 'methods' do
    it '#symptom_description' do
      user = create(:user)
      symptom = Symptom.create!(description: "Headache")
      log = Log.create!(user: user, symptom: symptom, when: DateTime.now)
      expect(log.symptom_description).to eq("Headache")
    end

    it '::potential_symptoms' do
      user_1 = create(:user)
      medication_1 = create(:medication)
      symptom_1 = Symptom.create!(description: "Headache")
      symptom_2 = Symptom.create!(description: "Insomnia")
      MedicationSymptom.create!(medication: medication_1, symptom: symptom_1)
      MedicationSymptom.create!(medication: medication_1, symptom: symptom_2)
      UserMedication.create!(user: user_1, medication: medication_1)

      user_2 = create(:user)
      medication_2 = create(:medication, brand_name: "Xanax")
      symptom_3 = Symptom.create!(description: "Stomach pain")
      MedicationSymptom.create!(medication: medication_2, symptom: symptom_3)
      UserMedication.create!(user: user_2, medication: medication_2)

      expect(Symptom.potential_symptoms(user_1)).to_not eq(Symptom.potential_symptoms(user_2))

      expect(Symptom.potential_symptoms(user_1)).to include(symptom_1)
      expect(Symptom.potential_symptoms(user_1)).to include(symptom_2)
      expect(Symptom.potential_symptoms(user_1)).to_not include(symptom_3)

      expect(Symptom.potential_symptoms(user_2)).to include(symptom_3)
      expect(Symptom.potential_symptoms(user_2)).to_not include(symptom_1)
      expect(Symptom.potential_symptoms(user_2)).to_not include(symptom_2)
    end
  end
end
