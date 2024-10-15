require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should belong_to(:company).class_name('Company') }
    it { should have_many(:managed_users).class_name('User') }
    it { should belong_to(:leader).class_name('User').optional }
    it { should belong_to(:leadership_level).class_name('LeadershipLevel').optional }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
