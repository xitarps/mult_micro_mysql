require 'rails_helper'

RSpec.describe Users::FetchSubManagedUsersService, type: :model do
  let(:company) { create(:company, :full_structure) }
  let(:leadership_level) { company.leadership_levels.first }
  let(:owner) { company.users.first }
  let(:user_1) { create(:user, company: company) }
  let(:user_2) { create(:user, company: company) }
  let(:user_3) { create(:user, company: company) }

  describe '#call' do
    it 'returns second level managed users' do
      Users::JoinsLeaderService.call(user: user_1, leader: owner)
      Users::JoinsLeaderService.call(user: user_2, leader: user_1)
      Users::JoinsLeaderService.call(user: user_3, leader: user_1)

      expect(described_class.call(leader_id: owner.id)).to include(user_2, user_3)
    end
  end
end
