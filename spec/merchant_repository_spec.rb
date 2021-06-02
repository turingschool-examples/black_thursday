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

      expect(merchant_repo.all.length).to eq(4)
    end
  end

  describe 'attributes' do
    it 'can read Merchant attributes' do
      path = 'fixture/merchant_fixture.csv'
      merchant_repo = MerchantRepository.new(path)

      all = merchant_repo.all

      expect(all.first.id).to eq(12334471)
      expect(all.last.name).to eq('MittenUpCanada')
    end

    it 'can find by Merchant ID' do
      path = 'fixture/merchant_fixture.csv'
      merchant_repo = MerchantRepository.new(path)

      merchant_repo.create_merchants(path)

      expect(merchant_repo.find_by_id(12337011)).to eq(merchant_repo.all[2])
    end
  end
end
