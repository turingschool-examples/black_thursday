# frozen_string_literal: true

require 'rspec'
require './lib/merchant'
require './lib/merchant_repository'

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
  end

  describe '#find_by_name' do
    it 'finds a merchant by the given name' do
      details = MockData.merchants_as_hash
      mock_data = MockData.merchants_as_mocks(details) { self }
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_data)
      m_repo = MerchantRepository.new('fake.csv')

      expected = m_repo.merchants.first
      actual = m_repo.find_by_name('Merchant 0')

      expect(actual).to eq expected
    end
  end

  describe '#find_all_by_name' do
    it 'finds all merchants by the given name' do
      details = MockData.merchants_as_hash
      mock_data = MockData.merchants_as_mocks(details) { self }
      allow_any_instance_of(MerchantRepository).to receive(:create_merchants).and_return(mock_data)
      m_repo = MerchantRepository.new('fake.csv')

      expected = [m_repo.merchants.first]
      actual = m_repo.find_all_by_name('Merchant 0')

      expect(actual).to eq expected
    end
  end

  # describe '#delete' do
  #   it 'deletes a merchant with the given id' do
  #     mock_merchant1 = instance_double('Merchant', id: 0)
  #     mock_merchant2 = instance_double('Merchant', id: 1)
  #     mock_merchant3 = instance_double('Merchant', id: 2)
  #     mock_merchant4 = instance_double('Merchant', id: 3)
  #     mock_merchants = [mock_merchant1, mock_merchant2,
  #                       mock_merchant3, mock_merchant4]
  #
  #     m_repo = MerchantRepository.new(mock_merchants)
  #
  #     expected_merchants = [mock_merchant1, mock_merchant2, mock_merchant4]
  #     m_repo.delete(2)
  #     actual_merchants = m_repo.all
  #     expect(actual_merchants).to eq expected_merchants
  #   end
  # end
  #
  # describe '#create' do
  #   it 'creates a new Merchant' do
  #     merchant1 = Merchant.new(id: 1, name: 'Richard')
  #
  #     merchant2 = Merchant.new(id: 2, name: 'Dustin')
  #
  #     merchants = [merchant1, merchant2]
  #     m_repo = MerchantRepository.new(merchants)
  #
  #     allow(m_repo).to receive(:newest_id).and_return(3)
  #
  #     m_repo.create(id: 0, name: 'Sami')
  #
  #     merchant_names = [merchant1.name, merchant2.name, 'Sami']
  #     actual_names = m_repo.all.map(&:name)
  #
  #     expect(actual_names).to eq merchant_names
  #   end
  # end
  #
  # describe '#newest_id' do
  #   it 'gets the next id for a new merchant' do
  #     merchant1 = Merchant.new(id: 1, name: 'Richard')
  #     merchants = [merchant1]
  #     m_repo = MerchantRepository.new(merchants)
  #
  #     expect_new_id = 2
  #     actual_id = m_repo.newest_id
  #
  #     expect(actual_id).to eq expect_new_id
  #   end
  # end
  #
  # describe '#update' do
  #   it 'updates a merchant with the given id and attributes' do
  #     merchant1 = Merchant.new(id: 1, name: 'Richard')
  #     merchant2 = Merchant.new(id: 2, name: 'Dustin')
  #     merchant3 = Merchant.new(id: 3, name: 'Ashley')
  #     merchants = [merchant1, merchant2, merchant3]
  #     m_repo = MerchantRepository.new(merchants)
  #     m_repo.update(2, id: 23, name: 'Dustin Huntsman')
  #
  #     expect(merchant2.name).to eq 'Dustin Huntsman'
  #     expect(merchant2.id).not_to eq 23
  #   end
  # end
end
