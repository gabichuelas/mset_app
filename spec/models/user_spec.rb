RSpec.describe User do
  it { should validate_presence_of :uid }
  it { should validate_presence_of :email }
  it { should validate_presence_of :access_token }
  it { should validate_presence_of :refresh_token }
  # it { should validate_presence_of :first_name }
  # it { should validate_presence_of :last_name }
  # it { should validate_presence_of :birthdate }
  # it { should validate_presence_of :age }
  # it { should validate_presence_of :weight }
  # do we want age in years or birthdate

  it { should have_many :logs }
  it { should have_many(:symptoms).through(:logs) }
end
