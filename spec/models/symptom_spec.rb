RSpec.describe Symptom do
  it { should validate_presence_of :description }

  # it { should have_many :medication_symptoms }
  # it { should have_many(:medications).through(:medication_symptoms) }

  it { should have_many :logs }
end
