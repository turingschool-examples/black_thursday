require './lib/merchant'
require './lib/merchant_repository'
require 'CSV'

RSpec.describe MerchantRepository do
  describe '#initialize' do
    it 'exists' do
      path = "fixture/merchant_fixture.csv"
      merchant_repo = MerchantRepository.new(path)

      expect(merchant_repo).to be_a(MerchantRepository)
    end

    it 'has an array of all merchant instances' do
      path = 'fixture/merchant_fixture.csv'
      merchant_repo = MerchantRepository.new(path)

      expect(merchant_repo.all.length).to eq(5)
    end
  end

  describe 'attributes' do
    it 'can read Merchant attributes' do
      path = 'fixture/merchant_fixture.csv'
      merchant_repo = MerchantRepository.new(path)

      # creates new object instance of merchant objects?
      all = merchant_repo.all

      expect(all.first.id).to eq(12334471)
      expect(all.last.name).to eq('FrenchyTrendy')
    end

    it 'can find Merchant by ID' do
      path = 'fixture/merchant_fixture.csv'
      merchant_repo = MerchantRepository.new(path)

      merchant_repo.create_merchants(path)

      id = 12337011
      expected = merchant_repo.find_by_id(id)

      expect(expected.id).to eq(id)
    end

    it 'can find Merchant by name' do
      path = 'fixture/merchant_fixture.csv'
      merchant_repo = MerchantRepository.new(path)

      merchant_repo.create_merchants(path)

      expect(merchant_repo.find_by_name('hollipoop')).to eq(merchant_repo.all.first)
      expect(merchant_repo.find_by_name('HOLLIPOOP')).to eq(merchant_repo.all.first)
    end

    it 'can find all merchants by name fragment' do
      path = 'fixture/merchant_fixture.csv'
      merchant_repo = MerchantRepository.new(path)

      merchant_repo.create_merchants(path)
      name = 'french'
      expected = merchant_repo.find_all_by_name(name)

      expect(expected.length).to eq(2)
      expect(expected.first.id).to eq(12334473)
    end
  end
end
