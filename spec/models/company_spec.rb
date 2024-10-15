require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'associations' do
    # it { should belong_to(:category).class_name('MenuCategory') }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
