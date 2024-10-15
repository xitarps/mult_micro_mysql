FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    users { [create(:user, level: 0, company_id: 1)] }
  end
end
