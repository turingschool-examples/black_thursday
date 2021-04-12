require 'rspec'
require './lib.merchant_repository'

describe MerchantRepository do
  describe '#new' do
    it 'creates a new instance' do
      m_repo = MerchantRepository.new
      expect(m_repo).to eq MerchantRepository
    end
  end
end
