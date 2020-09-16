RSpec.describe Log do
  describe 'validations' do
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :symptom_id }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :symptom }
  end

  describe 'methods' do
    it '::order_by_when' do
      user = create(:user)

      symptom_1 = Symptom.create!(description: "Headache")
      symptom_2 = Symptom.create!(description: "Insomnia")
      symptom_3 = Symptom.create!(description: "Death")

      log_1_time = DateTime.new(2004,2,3,4,5,0, '+6:00')
      log_1 = Log.create(user: user, symptom: symptom_1, when: log_1_time)

      log_2_time = DateTime.new(2003,2,3,4,5,0, '+6:00')
      log_2 = Log.create(user: user, symptom: symptom_2, when: log_2_time)

      log_3_time = DateTime.new(2005,2,3,4,5,0, '+6:00')
      log_3 = Log.create(user: user, symptom: symptom_3, when: log_3_time)

      ordered_logs = [log_3, log_1, log_2]

      expect(Log.order_by_when).to eq(ordered_logs)
    end
  end
end
