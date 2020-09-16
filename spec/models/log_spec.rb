RSpec.describe Log do
  describe 'validations' do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :symptom_id }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :symptom }
  end

  describe 'methods' do
    it '::order_by_when' do
      user = create(:user)

      symptom_1 = Symptom.create!(description: "Headache")
      symptom_2 = Symptom.create!(description: "Insomnia")
      symptom_3 = Symptom.create!(description: "Death")

      log_1_time = DateTime.new(2004,2,3,4,5,0, '+6:00')
      log_1 = Log.create(user: user, symptom: symptom_1, when: log_1_time)

      log_2_time = DateTime.new(2003,2,3,4,5,0, '+6:00')
      log_2 = Log.create(user: user, symptom: symptom_2, when: log_2_time)

      log_3_time = DateTime.new(2005,2,3,4,5,0, '+6:00')
      log_3 = Log.create(user: user, symptom: symptom_3, when: log_3_time)

      ordered_logs = [log_3, log_1, log_2]

      expect(Log.order_by_when).to eq(ordered_logs)
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

# end
