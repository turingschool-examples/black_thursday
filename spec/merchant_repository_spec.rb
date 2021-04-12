require 'rspec'
require './lib/merchant_repository'

describe MerchantRepository do
  describe '#new' do
    it 'creates a new instance' do
      m_repo = MerchantRepository.new
      expect(m_repo).to be_instance_of MerchantRepository
    end
    it 'has by default an empty repo' do
      m_repo = MerchantRepository.new
      expect(m_repo.all).to eq []
    end
  end

  describe '#all' do
    it 'returns the list of Merchants' do
      mock_merchants = ['mock1', 'mock2', 'mock3']
      m_repo = MerchantRepository.new(mock_merchants)
      expect(m_repo.all).to eq mock_merchants
    end
  end
end
