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

  describe '#find_by_id' do
    it 'finds the merchant by the given id' do
      mock_merchant_1 = instance_double('Merchant', :id => 1)
      mock_merchant_2 = instance_double('Merchant', :id => 2)
      mock_merchant_3 = instance_double('Merchant', :id => 3)
      mock_merchants = [mock_merchant_1, mock_merchant_2, mock_merchant_3]

      m_repo = MerchantRepository.new(mock_merchants)

      expected_merchant = mock_merchant_2
      actual_merchant = m_repo.find_by_id(2)

      expect(actual_merchant).to eq expected_merchant
    end
  end

  describe '#find_by_name' do
    it 'finds a merchant by the given name' do
      mock_merchant_1 = instance_double('Merchant', :name => 'Mark')
      mock_merchant_2 = instance_double('Merchant', :name => 'Rich')
      mock_merchant_3 = instance_double('Merchant', :name => 'Dustin')
      mock_merchants = [mock_merchant_1, mock_merchant_2, mock_merchant_3]

      m_repo = MerchantRepository.new(mock_merchants)

      expected_merchant = mock_merchant_3
      actual_merchant = m_repo.find_by_name('Dustin')

      expect(actual_merchant).to eq expected_merchant
    end
  end

  describe '#find_all_by_name' do
    it 'finds all merchants by the given name' do
      mock_merchant_1 = instance_double('Merchant', :name => 'Mark')
      mock_merchant_2 = instance_double('Merchant', :name => 'Rich')
      mock_merchant_3 = instance_double('Merchant', :name => 'Dustin')
      mock_merchant_4 = instance_double('Merchant', :name => 'Dustin')
      mock_merchant_5 = instance_double('Merchant', :name => 'Frank')
      mock_merchants = [mock_merchant_1, mock_merchant_2, mock_merchant_3, mock_merchant_4, mock_merchant_5]

      m_repo = MerchantRepository.new(mock_merchants)

      expected_merchants = [mock_merchant_3, mock_merchant_4]
      actual_merchants = m_repo.find_all_by_name('Dustin')

      expect(actual_merchants).to eq expected_merchants
    end
  end

  describe '#delete' do
    it 'deletes a merchant with the given id' do
      mock_merchant_1 = instance_double('Merchant', :id => 0)
      mock_merchant_2 = instance_double('Merchant', :id => 1)
      mock_merchant_3 = instance_double('Merchant', :id => 2)
      mock_merchant_4 = instance_double('Merchant', :id => 3)
      mock_merchants = [mock_merchant_1, mock_merchant_2, mock_merchant_3, mock_merchant_4]

      m_repo = MerchantRepository.new(mock_merchants)

      expected_merchants = [mock_merchant_1, mock_merchant_2, mock_merchant_4]
      m_repo.delete(2)
      actual_merchants = m_repo.all
      expect(actual_merchants).to eq expected_merchants
    end
  end
end
