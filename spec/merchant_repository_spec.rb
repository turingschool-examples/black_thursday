require './lib/sales_engine'
require './lib/merchant_repository'
# require 'simplecov'
RSpec.describe MerchantRepository do

  # Parameter (array of hashes) should be passed
  # into new instance
  describe 'initialization' do
    sales_engine = SalesEngine.from_csv({
                                        :items     => "./data/items.csv",
                                        :merchants => "./data/merchants.csv",
                                        })
    merch_rep = sales_engine.merchants

    it 'exists' do
      expect(merch_rep).to be_instance_of(MerchantRepository)
    end

    it 'can access merchants' do
      expect(merch_rep.merchants[0]).to be_instance_of(Merchant)
    end

    it 'can create merchant objects' do
      merchant_data = SalesEngine.parse_csv("./data/merchants.csv")
      expect(merch_rep.create_merchants(merchant_data)[0]).to be_instance_of(Merchant)
    end
  end

  describe 'database functionality' do
    sales_engine = SalesEngine.from_csv({
                                        :items     => "./data/items.csv",
                                        :merchants => "./data/merchants.csv",
                                        })
    merch_rep = sales_engine.merchants

    it 'returns array of all merchants' do
      merchant_count = merch_rep.merchants.count
      expect(merch_rep.all.count).to eq(merchant_count)
    end

    it 'can find by ID' do
      expect(merch_rep.find_by_id(500000)).to eq(nil)
      expect(merch_rep.find_by_id(12452)).to eq(nil)
    end

  end
end
