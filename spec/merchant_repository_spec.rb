require './lib/sales_engine'
require './lib/merchant_repository'
# require 'simplecov'
RSpec.describe MerchantRepository do

  # Parameter (array of hashes) should be passed
  # into new instance
  xdescribe 'initialization' do
    merch_rep = MerchantRepository.new()

    it 'exists' do
      expect(merch_rep).to be_instance_of(MerchantRepository)
    end

    it 'can create merchant objects' do
      merchant_data = SalesEngine.parse_csv("./data/merchants.csv")
      expect(sales_engine.create_merchants(merchant_data)[0]).to be_instance_of(Merchant)
    end

  end
end
