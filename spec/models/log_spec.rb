RSpec.describe Log do
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :symptom_id }

  it { should belong_to :user }
  it { should belong_to :symptom }
end
