require "CSV"
require "RSpec"
require "./lib/sales_engine"
require "./lib/item"
require "./lib/item_repo"
require "./lib/merchant_repo"

RSpec.describe SalesAnalyst do
  before(:each) do
    @repo = SalesEngine.from_csv({:items => "./data/items.csv",
                                  :merchants => "./data/merchants.csv"})
  end

  describe 'instantiation' do
    it '::new' do
      sales_analyst = SalesAnalyst.new(@repo)

      expect(sales_analyst).to be_an_instance_of(SalesEngine)
    end
  end

  describe 'methods' do
    it '#average items per merhant' do
      analyst = SalesAnalyst.from_csv({:items => "./data/items.csv",
                            :merchants => "./data/merchants.csv"})

      expect(sales_analyst.average_items_per_mercaht).to eq(Float)
    end

    it '#standard deviation items per merhant' do
      analyst = SalesAnalyst.from_csv({:items => "./data/items.csv",
                            :merchants => "./data/merchants.csv"})

      expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(Float)
    end

    it '#merchant with highest item count' do
      analyst = SalesAnalyst.from_csv({:items => "./data/items.csv",
                            :merchants => "./data/merchants.csv"})

      expect(sales_analyst.merchants_with_high_item_count).to eq(merchant)
    end

    it '#average item price for merchant' do
      analyst = SalesAnalyst.from_csv({:items => "./data/items.csv",
                          :merchants => "./data/merchants.csv"})

      expect(sales_analyst.average_item_price_for_merchant(merchant id).to eq(BigDecimal)
    end

    it '#average average price per merchant' do
      analyst = SalesAnalyst.from_csv({:items => "./data/items.csv",
                          :merchants => "./data/merchants.csv"})

      expect(sales_analyst.average_average_price_per_merchant).to eq(BigDecimal)
    end

    it '#golden item' do
      analyst = SalesAnalyst.from_csv({:items => "./data/items.csv",
                        :merchants => "./data/merchants.csv"})

      expect(sales_analyst.golden_items).to eq(Item)
    end
  end
end
