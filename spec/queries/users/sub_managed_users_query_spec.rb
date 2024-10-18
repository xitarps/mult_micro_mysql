require 'rails_helper'

RSpec.describe Users::SubManagedUsersQuery, type: :model do
  describe '#call' do
    let(:fixture) { yml_hash_from_query_file('users/sub_managed_users_query.yml') }

    it 'raises an "interfac implementation error"' do
      real_result = minify_query_to_single_line(described_class.call)
      expected_result = minify_query_to_single_line(fixture[:queries][:users][:depth][:two])

      expect(real_result).to eq(expected_result)
    end
  end
end
