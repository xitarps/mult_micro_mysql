FactoryBot.define do
  factory :leadership_level do
    level { 0 }
    company { nil }
    users { [] }
  end
end
