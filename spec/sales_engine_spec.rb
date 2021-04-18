require "CSV"
require "RSpec"
require "./lib/sales_engine"
require "./lib/item"
require "./lib/item_repo"
require "./lib/merchant_repo"
require "./lib/sales_analyst"

RSpec.describe SalesEngine do
  describe 'instantiation' do
    it '::new' do
      se = SalesEngine.from_csv({:items => "./data/items.csv",
                            :merchants => "./data/merchants.csv"},)

      expect(se).to be_an_instance_of(SalesEngine)
    end

    it 'has attributes' do
      se = SalesEngine.from_csv({:items => "./data/items.csv",
                                 :merchants => "./data/merchants.csv"})

      expect(se.items).to be_an_instance_of ItemRepo
      expect(se.merchants).to be_an_instance_of MerchantRepo
    end
  end

  #do we actually need this test?
  # describe 'method' do
  #   it '#from_csv' do
  #   se = SalesEngine.from_csv({:items => "./data/items.csv",
  #                               :merchants => "./data/merchants.csv"})

  #     # expect(thepart.confusion)
  #   end
  # end
end
