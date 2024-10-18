FactoryBot.define do
  factory :user do
    level { nil }
    leadership_level { nil }
    company { nil }
    name { Faker::Name.name }
    email { Faker::Internet.email }
    user_id { nil }
  end

  trait :owner do
    name { 'Owner - ' << Faker::Name.name }
  end
end
