require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'associations' do
    it { should have_many(:leadership_levels) }
  end

  describe 'validations' do
    subject { create(:company) }
    it { should validate_presence_of(:name) }
  end
end
