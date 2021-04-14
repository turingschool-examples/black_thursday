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
end