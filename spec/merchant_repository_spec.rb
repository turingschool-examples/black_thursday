require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/merchant_repository'

RSpec.describe MerchantRepository do
  describe '#initialize' do
    it 'exists' do
      se = SalesEngine.new
      mr = se.merchants

      expect(mr).to be_instance_of(MerchantRepository)
    end

    it 'has merchants' do
      se = SalesEngine.new
      mr = se.merchants

      expect(mr.merchants[0]).to be_a(Merchant)
    end
  end

  describe '#all' do
    it 'returns all merchants' do
      mr = MerchantRepository.new('./data/merchants_truncated.csv')

      expect(mr.all).to be_a(Array)
      expect(mr.all.count).to eq(3)
      expect(mr.all[0]).to be_a(Merchant)
    end
  end

  describe '#find_by_id' do
    it 'finds by id or returns nil' do
      mr = MerchantRepository.new('./data/merchants_truncated.csv')

      expect(mr.find_by_id(3)).to eq(nil)
      expect(mr.find_by_id(12334105)).to eq(mr.merchants[0])
    end
  end
end