FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    leadership_levels { [] }
    users { [] }

    trait :full_structure do
      after(:build) do |company, evaluator|
        company.users = [build(:user, :owner, level: 0)]
        company.save
        user = company.users.first
        user.company = company
        user.save
        company.save(validate: false)
        leadership_level = build(:leadership_level, company: company, users: company.users)
        company.reload
      end
    end

  end
end
