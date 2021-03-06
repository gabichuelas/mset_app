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
      @medication = create(:medication)
      @medication2 = create(:medication)
    end

    it "user#full_name" do
      expect(@user.full_name).to eq("Joe Doe")
    end

    it "user#has_medication?" do
     UserMedication.create(user_id: @user.id, medication_id: @medication.id)
     expect(@user.has_medication?(@medication.id)).to eq(true)
     expect(@user.has_medication?(@medication2.id)).to eq(false)
    end

    it "user#add_medication" do
      @user.add_medication(@medication.id)
      expect(@user.has_medication?(@medication.id)).to eq(true)
      expect(@user.has_medication?(@medication2.id)).to eq(false)
    end

    it 'user#most_recent_logs' do
      create_list(:symptom, 10)

      symptoms = Symptom.all

      15.times do
        Log.create(user: @user, symptom: symptoms.sample, note: Faker::Marketing.buzzwords, when: Faker::Date.in_date_period)
      end

      expect(@user.most_recent_logs.length).to eq(10)
      expect(@user.most_recent_logs[0].when >= @user.most_recent_logs[1].when).to eq(true)
      expect(@user.most_recent_logs[1].when >= @user.most_recent_logs[2].when).to eq(true)
    end
  end
end
