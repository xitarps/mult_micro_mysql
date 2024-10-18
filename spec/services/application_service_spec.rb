require 'rails_helper'

RSpec.describe ApplicationQuery, type: :model do
  describe '#call' do
    it 'raises an "interfac implementation error"' do
      expect { described_class.call }.to raise_error('Must implement method private \'run\'')
    end
  end
end
