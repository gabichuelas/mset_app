RSpec.describe Log do
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :symptom_id }

  it { should belong_to :user }
  it { should belong_to :symptom }

  it "methods" do
    user = create(:user)
    symptom = Symptom.create!(description: "Headache")
    log = Log.create!(user: user, symptom: symptom, when: DateTime.now)
    expect(log.symptom_description).to eq("Headache")
  end
end
