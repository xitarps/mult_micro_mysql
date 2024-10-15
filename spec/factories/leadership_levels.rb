FactoryBot.define do
  factory :leadership_level do
    level { 0 }
    company { create(:company) }
  end
end
