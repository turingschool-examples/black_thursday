require './lib/merchant_repository'
require './lib/sales_engine'

RSpec.describe SalesEngine do

  it "exists" do
      sales_engine = SalesEngine.from_csv({
        # :items => "./data/items.csv",
        :merchants => "./data/merchants.csv"
      })
      expect(sales_engine).to be_instance_of SalesEngine
    end

    xit "can return an array of all items" do
      sales_engine = SalesEngine.from_csv({
        :items => "./data/items.csv",
        :merchants => "./data/merchants.csv"
      })

      expect(sales_engine.item_collection).to be_instance_of ItemCollection



    end

    xit "can return an array of all merchants" do
      sales_engine = SalesEngine.from_csv({
        :items => "./data/items.csv",
        :merchants => "./data/merchants.csv"
      })

      expect(sales_engine.merchant_repository).to be_instance_of MerchantCollection

      expect(sales_engine.merchants_repository.all).to be_a Array

      expect(sales_engine.merchant_repository.all.length).to eq(475)



    end

  end
