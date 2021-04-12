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
end
