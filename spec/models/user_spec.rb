RSpec.describe User do
  it { should validate_presence_of :uid }
  it { should validate_presence_of :email }
  it { should validate_presence_of :access_token }

  it { should have_many :logs }
  it { should have_many(:symptoms).through(:logs) }

  it "user#full_name" do
    user = create(:user, first_name: "Joe", last_name: "Doe")
    expect(user.full_name).to eq("Joe Doe")
  end
end
