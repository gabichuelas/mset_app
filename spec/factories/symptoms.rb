FactoryBot.define do
  factory :symptom do
    description { Faker::Beer.name }
  end
end
