RSpec.describe User do
  it { should validate_presence_of :uid }
  it { should validate_presence_of :email }
  it { should validate_presence_of :access_token }

  it { should have_many :logs }
  it { should have_many(:symptoms).through(:logs) }
  it { should have_many :user_medications }
  it { should have_many(:medications).through(:user_medications) }

  describe "instance methods" do
    before :each do
      @user = create(:user, first_name: "Joe", last_name: "Doe")
    end

    it "user#full_name" do
      expect(@user.full_name).to eq("Joe Doe")
    end

    it "user#has_medication?" do
      medication = create(:medication)
      medication2 = create(:medication)
      UserMedication.create(user_id: @user.id, medication_id: medication.id)
      expect(@user.has_medication?(medication.id)).to eq(true)
      expect(@user.has_medication?(medication2.id)).to eq(false)
    end
  end
end
