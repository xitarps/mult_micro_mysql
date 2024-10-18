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

  describe '#call' do
    it 'joins leader with managed_user' do
      described_class.call(user: user_1, leader: owner)

      expect(owner.managed_users).to include(user_1)
    end

    it 'raises error: \'Leader must be in the hierarchy(level can\'t be nil\'' do
      message = "Leader must be in the hierarchy(level can't be nil)"
      expect { described_class.call(user: user_2, leader: user_1) }.to raise_error(RuntimeError, message)
    end

    it 'raises error: \'User can\'t be on equal or higher level than the leader\'' do
      described_class.call(user: user_1, leader: owner)
      described_class.call(user: user_2, leader: user_1)
      described_class.call(user: user_3, leader: user_2)

      message = "User can't be on equal or higher level than the leader"
      expect { described_class.call(user: user_2, leader: user_3) }.to raise_error(RuntimeError, message)
    end

    it 'raises error: \'Either User and Leader must be from the same company\'' do
      message = 'Either User and Leader must be from the same company'
      expect { described_class.call(user: user_1, leader: other_company_owner) }.to raise_error(RuntimeError, message)
    end

    it 'raises error: \'Either User and Leader must be \'User\' type, got: NilClass and Integer\'' do
      message = "Either User and Leader must be 'User' type, got: NilClass and Integer"
      expect { described_class.call(user: nil, leader: 1) }.to raise_error(RuntimeError, message)
    end
  end
end
