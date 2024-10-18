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

  context '.handle_managed_users_leaderships' do
    it 'runs .relocate_managed_users_with_upper_leader' do
      allow(subject).to receive(:relocate_managed_users_with_upper_leader).and_return('successfully called')
      result = subject.send(:handle_managed_users_leaderships)
      expect(result).to eq('successfully called')
    end
  end

  context '.relocate_managed_users_with_upper_leader' do
    it 'runs Users::JoinsLeaderService.call' do
      params = { user: subject, leader: subject }
      user_managed_users = [params, params]
      allow(subject).to receive(:managed_users).and_return(user_managed_users)
      allow(Users::JoinsLeaderService).to receive(:call).and_return('successfully called')

      subject.send(:relocate_managed_users_with_upper_leader)
      expect(Users::JoinsLeaderService).to have_received(:call).exactly(user_managed_users.size).times
    end
  end
end
