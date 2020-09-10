RSpec.describe Log do
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :symptom_id }
  it { should validate_presence_of :time }
  # it { should validate_presence_of :note }

  it { should belong_to :user }
  it { should belong_to :symptom }
end
