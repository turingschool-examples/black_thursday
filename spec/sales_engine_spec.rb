require "CSV"
require "RSpec"
require "./lib/sales_engine"
require "./lib/item"
require "./lib/item_repo"
require "./lib/merchant_repo"

RSpec.describe SalesEngine do
  describe 'instantiation' do
    it '::new' do

      se = SalesEngine.new({:items => ItemRepo.new,
                            :merchants => MerchantRepo.new})

      expect(se).to be_an_instance_of(SalesEngine)
    end

    it 'has attributes' do
      se = SalesEngine.new({:items => ItemRepo.new(),
                            :merchants => MerchantRepo.new})
   
      # expect(se.item).to eq('./data/items.csv')
      # expect(se.merchant).to eq('./data/merchants.csv')
      expect(se.item).to be_an_instance_of ItemRepo
      expect(se.merchant).to be_an_instance_of MerchantRepo
    end
  end

  describe 'method' do
    xit '#from_csv' do
      se = SalesEngine.new({:items => "./data/items.csv",
                            :merchants => "./data/merchants.csv",})
      se = SalesEngine.from_csv({:items => "./data/items.csv",
                                 :merchants => "./data/merchants.csv",})

      # expect(thepart.confusion)
    end
  end
end
