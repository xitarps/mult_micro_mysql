FactoryBot.define do
  factory :user do
    level { 1 }
    leadership_level { nil }
    company_id { 1 }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    user_id { nil }
  end
end
