RSpec.describe Medication do
  it { should validate_presence_of :brand_name }
  # it { should validate_presence_of :generic_name }
  it { should validate_presence_of :product_ndc }

  # it { should have_many :medication_symptoms }
  # it { should have_many(:symptoms).through(:medication_symptoms) }

  describe 'instance methods' do
    before :each do
      @medication = create(:medication)
    end

    it '#save_symptoms' do
      symptoms = [
        'headache',
        'nausea',
        'diarrhea'
      ]
      @medication.save_symptoms(symptoms)
      @medication.symptoms.each do |symptom|
        expect(symptom.class).to eq(Symptom)
      end
      expect(@medication.symptoms.count).to eq(3)
    end
  end
end
