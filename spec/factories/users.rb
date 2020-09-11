FactoryBot.define do
  factory :user do
    uid { '1111' }
    email { 'user@gmail.com' }
    access_token { '1234user' }
    refresh_token { 'user1234' }
  end
end
