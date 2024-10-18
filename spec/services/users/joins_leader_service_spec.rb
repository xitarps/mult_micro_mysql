require 'rails_helper'

RSpec.describe Users::JoinsLeaderService, type: :model do
  let(:company) { create(:company, :full_structure) }
  let(:leadership_level) { company.leadership_levels.first }
  let(:owner) { company.users.first }
  let(:user_1) { create(:user, company: company) }
  let(:user_2) { create(:user, company: company) }
  let(:user_3) { create(:user, company: company) }

  let(:other_company) { create(:company, :full_structure) }
  let(:other_company_leadership_level) { other_company.leadership_levels.first }
  let(:other_company_owner) { other_company.users.first }
  let(:other_company_user_1) { create(:user, company: other_company) }

  describe '#call' do
    it 'joins leader with managed_user' do
      described_class.call(user: user_1, leader: owner)

      expect(owner.managed_users).to include(user_1)
    end

    it 'raises error: \'Leader must be in the hierarchy(level can\'t be nil\'' do
      expect{described_class.call(user: user_2, leader: user_1)}.to raise_error(RuntimeError, "Leader must be in the hierarchy(level can't be nil)")
    end

    it 'raises error: \'User can\'t be on equal or higher level than the leader\'' do
      described_class.call(user: user_1, leader: owner)
      described_class.call(user: user_2, leader: user_1)
      described_class.call(user: user_3, leader: user_2)

      expect{described_class.call(user: user_2, leader: user_3)}.to raise_error(RuntimeError, "User can't be on equal or higher level than the leader")
    end

    it 'raises error: \'Either User and Leader must be from the same company\'' do
      expect{described_class.call(user: user_1, leader: other_company_owner)}.to raise_error(RuntimeError, "Either User and Leader must be from the same company")
    end

    it 'raises error: \'Either User and Leader must be \'User\' type, got: NilClass and Integer\'' do
      expect{described_class.call(user: nil, leader: 1)}.to raise_error(RuntimeError, "Either User and Leader must be \'User\' type, got: NilClass and Integer")
    end
  end
end
