FactoryBot.define do
  factory :leadership_level do
    level { 1 }
    company { create(:company) }
  end
end
