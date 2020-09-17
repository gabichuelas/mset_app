FactoryBot.define do
  factory :medication do
    brand_name { 'Adderall' }
    product_ndc { Faker::Number.number(digits: 7) }
  end
end
