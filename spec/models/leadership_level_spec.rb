require 'rails_helper'

RSpec.describe LeadershipLevel, type: :model do
  describe 'associations' do
    it { should belong_to(:company).class_name('Company') }
  end

  describe 'validations' do
    subject { create(:leadership_level)  }
    it { should validate_presence_of(:level) }
  end
end
