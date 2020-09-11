RSpec.describe MedicationSymptom do
  it { should validate_presence_of :medication_id }
  it { should validate_presence_of :symptom_id }

  it { should belong_to :medication }
  it { should belong_to :symptom }
end
