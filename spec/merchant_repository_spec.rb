# frozen_string_literal: true

require 'rspec'
require './lib/merchant'
require './lib/merchant_repository'
require './data/mock_data'

describe MerchantRepository do
  describe '#initialize' do
    it 'exists' do
      mock_data = MockData.merchants_as_hash
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_data)
      m_repo = MerchantRepository.new('fake.csv')

      expect(m_repo).is_a? MerchantRepository
    end

    it 'has a merchants array' do
      mock_data = MockData.merchants_as_hash
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_data)
      m_repo = MerchantRepository.new('fake.csv')

      expect(m_repo.merchants).is_a? Array
    end
  end

  describe '#all' do
    it 'returns the list of Merchants' do
      details = MockData.merchants_as_hash
      mock_data = MockData.merchants_as_mocks(details) { self }
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_data)
      m_repo = MerchantRepository.new('fake.csv')

      expect(m_repo.all.length).to eq 10
    end
  end

  describe '#find_by_id' do
    it 'finds the merchant by the given id' do
      details = MockData.merchants_as_hash
      mock_data = MockData.merchants_as_mocks(details) { self }
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_data)
      m_repo = MerchantRepository.new('fake.csv')

      expected = m_repo.merchants.first
      actual = m_repo.find_by_id(0)
      expect(actual).to eq expected
    end

    it 'retunrs nil if no merchant exists for id' do
      details = MockData.merchants_as_hash
      mock_data = MockData.merchants_as_mocks(details) { self }
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_data)
      m_repo = MerchantRepository.new('fake.csv')

      actual = m_repo.find_by_id(30)
      expect(actual).to be_nil
    end
  end

  describe '#find_by_name' do
    it 'finds a merchant by the given name' do
      details = MockData.merchants_as_hash
      mock_data = MockData.merchants_as_mocks(details) { self }
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_data)
      m_repo = MerchantRepository.new('fake.csv')

      expected = m_repo.merchants.first
      actual = m_repo.find_by_name('MerCHant 0')
      expect(actual).to eq expected
    end
  end

  describe '#find_all_by_name' do
    it 'finds all merchants by the given name' do
      details = MockData.merchants_as_hash
      mock_data = MockData.merchants_as_mocks(details) { self }
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_data)
      m_repo = MerchantRepository.new('fake.csv')

      m_repo.create(id: 0, name: 'Merchant 0')
      new_merchant = m_repo.merchants.last

      expected = [m_repo.merchants.first, m_repo.merchants.last]
      actual = m_repo.find_all_by_name('CHant 0')
      expect(actual).to eq expected
    end
  end

  describe '#delete' do
    it 'deletes a merchant with the given id' do
      details = MockData.merchants_as_hash
      mock_data = MockData.merchants_as_mocks(details) { self }
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_data)
      m_repo = MerchantRepository.new('fake.csv')

      expect(m_repo.merchants.length).to eq 10
      m_repo.delete(2)
      expect(m_repo.merchants.length).to eq 9
    end
  end

  describe '#create' do
    it 'creates a new Merchant' do
      details = MockData.merchants_as_hash
      mock_data = MockData.merchants_as_mocks(details) { self }
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_data)
      m_repo = MerchantRepository.new('fake.csv')
      allow(m_repo).to receive(:newest_id).and_return(10)

      m_repo.create(id: 0, name: 'Sami')
      new_merchant = m_repo.merchants.last.name

      expect(m_repo.merchants.length).to eq 11
      expect(new_merchant).to eq 'Sami'
    end
  end

  describe '#newest_id' do
    it 'gets the next id for a new merchant' do
      details = MockData.merchants_as_hash
      mock_data = MockData.merchants_as_mocks(details) { self }
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_data)
      m_repo = MerchantRepository.new('fake.csv')

      expect(m_repo.newest_id).to eq 10
    end
  end

  describe '#update' do
    it 'updates a merchant with the given id and attributes' do
      details = MockData.merchants_as_hash
      mock_data = MockData.merchants_as_mocks(details) { self }
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_data)
      m_repo = MerchantRepository.new('fake.csv')

      m_repo.create(id: 0, name: 'Sami')
      new_merchant = m_repo.merchants.last
      m_repo.update(10, { id: 23, name: 'Dustin Huntsman' })

      expect(new_merchant.name).to eq 'Dustin Huntsman'
      expect(new_merchant.id).not_to eq 23
    end

    it 'does nothing if no merchant with given id and attributes' do
      details = MockData.merchants_as_hash
      mock_data = MockData.merchants_as_mocks(details) { self }
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_data)
      m_repo = MerchantRepository.new('fake.csv')

      m_repo.create(id: 0, name: 'Sami')
      new_merchant = m_repo.merchants.last
      m_repo.update(56, { id: 23, name: 'Dustin Huntsman' })
    end
  end
end
