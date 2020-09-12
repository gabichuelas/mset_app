RSpec.describe Medication do
  it { should validate_presence_of :brand_name }
  # it { should validate_presence_of :generic_name }
  it { should validate_presence_of :product_ndc }

  it { should have_many :user_medications }
  it { should have_many(:users).through(:user_medications) }
end
