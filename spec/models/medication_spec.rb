RSpec.describe Medication do
  it { should validate_presence_of :brand_name }
  # it { should validate_presence_of :generic_name }
  it { should validate_presence_of :product_ndc }

  it { should have_many :medication_symptoms }
  it { should have_many(:symptoms).through(:medication_symptoms) }
end
