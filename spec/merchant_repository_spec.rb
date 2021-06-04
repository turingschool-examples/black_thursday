require 'rspec'
require './lib/merchant_repository'
require './lib/sales_engine'
require 'simplecov'
SimpleCov.start

RSpec.describe do
  describe MerchantRepository do
    it 'exists' do
      mock_engine = double("salesengine mock")
      merch_repo = MerchantRepository.new('./spec/fixtures/merchant_fixtures.csv', mock_engine)

      expect(merch_repo).to be_an_instance_of(MerchantRepository)

    end

    it 'has attributes' do
      mock_engine = double("salesengine mock")
      merch_repo = MerchantRepository.new('./spec/fixtures/merchant_fixtures.csv', mock_engine)
      expect(merch_repo.merchants).to eq([])

      merch_repo.create_repo

      expect(merch_repo.merchants.count).to eq(10)
      expect(merch_repo.file_path).to eq('./spec/fixtures/merchant_fixtures.csv')
      expect(merch_repo.engine).to eq(mock_engine)
    end
  end
  describe 'its methods' do
    it 'can create a repo' do
      mock_engine = double("salesengine mock")
      merch_repo = MerchantRepository.new('./spec/fixtures/merchant_fixtures.csv', mock_engine)
      merch_repo.create_repo
      expect(merch_repo.merchants.count).to eq(10)
    end

    it 'can determine all of its merchants' do
      mock_engine = double("salesengine mock")
      merch_repo = MerchantRepository.new('./spec/fixtures/merchant_fixtures.csv', mock_engine)
      merch_repo.create_repo
      expect(merch_repo.all.count).to eq(10)
    end

    it 'can find by id' do
      mock_engine = double("salesengine mock")
      merch_repo = MerchantRepository.new('./spec/fixtures/merchant_fixtures.csv', mock_engine)
      merch_repo.create_repo

      expect(merch_repo.find_by_id(12334123)).to be_a(Merchant)
      expect(merch_repo.find_by_id(1224)).to eq(nil)
    end

    it 'can find by name' do
      mock_engine = double("salesengine mock")
      merch_repo = MerchantRepository.new('./spec/fixtures/merchant_fixtures.csv', mock_engine)
      merch_repo.create_repo

      expect(merch_repo.find_by_name('Keckenbauer')).to be_a(Merchant)
      expect(merch_repo.find_by_name('Frank')).to eq(nil)
    end

    it 'can find all by name' do
      mock_engine = double("salesengine mock")
      merch_repo = MerchantRepository.new('./spec/fixtures/merchant_fixtures.csv', mock_engine)
      merch_repo.create_repo

      expect(merch_repo.find_all_by_name('Keckenbauer').count).to eq(2)
      expect(merch_repo.find_all_by_name('Frank')).to eq([])
    end

    it 'can create a new merchant' do
      mock_engine = double("salesengine mock")
      merch_repo = MerchantRepository.new('./spec/fixtures/merchant_fixtures.csv', mock_engine)
      merch_repo.create_repo

      expect(merch_repo.all.count).to eq(10)

      merch_repo.create({
        name: 'Luis store',
        id: 12345,
        created_at: 2002-06-11,
        updated_at: 2021-06-03
        })

      expect(merch_repo.all.count).to eq(11)
      expect(merch_repo.find_by_name('Luis store')).to be_a(Merchant)
    end

    it 'can create a new merchant' do
      mock_engine = double("salesengine mock")
      merch_repo = MerchantRepository.new('./spec/fixtures/merchant_fixtures.csv', mock_engine)
      merch_repo.create_repo

      expect(merch_repo.find_by_id(12334442).name).to eq("isincerely88")

      merch_repo.update(12334442, {
        name: 'EzzeBrianLuis'
        })

      expect(merch_repo.find_by_id(12334442).name).to eq("EzzeBrianLuis")
    end

    it 'can delete a merchant' do
      mock_engine = double("salesengine mock")
      merch_repo = MerchantRepository.new('./spec/fixtures/merchant_fixtures.csv', mock_engine)
      merch_repo.create_repo

      expect(merch_repo.merchants.count).to eq(10)

      merch_repo.delete(12334442)

      expect(merch_repo.merchants.count).to eq(9)
    end
  end
end
