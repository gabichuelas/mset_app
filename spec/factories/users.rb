FactoryBot.define do
  factory :user do
    uid { '1111' }
    email { 'user@gmail.com' }
    access_token { '1234user' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birthdate { "1985-09-01" }
    weight { Faker::Number.between(from: 125, to: 250) }
  end
end
