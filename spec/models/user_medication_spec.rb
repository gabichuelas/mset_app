RSpec.describe UserMedication do
  it { should belong_to :user }
  it { should belong_to :medication }
end
