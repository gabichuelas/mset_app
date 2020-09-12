RSpec.describe User do
  it { should validate_presence_of :uid }
  it { should validate_presence_of :email }
  it { should validate_presence_of :access_token }

  it { should have_many :logs }
  it { should have_many(:symptoms).through(:logs) }
end
