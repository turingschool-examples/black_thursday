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
end
