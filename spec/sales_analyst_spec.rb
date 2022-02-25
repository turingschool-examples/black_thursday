require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require 'CSV'
require 'simplecov'
SimpleCov.start

RSpec.describe SalesAnalyst do

  before(:each) do
    @sales_engine = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          })
    @sales_analyst = @sales_engine.analyst
  end

  describe 'creates a working sales analyst' do

    it 'exists' do
      expect(@sales_analyst).to be_a(SalesAnalyst)
    end

    it 'can calculate average items per merchant' do
      expect(@sales_analyst.average_items_per_merchant).to eq(2.88)
    end

    it 'can calculate average items per merchant standard deviation' do
      expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
    end

    it 'dispays merchants with high item count' do
      expect(@sales_analyst.merchants_with_high_item_count[0]).to be_a(Merchant)
      expect(@sales_analyst.merchants_with_high_item_count.count).to eq(52)
    end

    it 'finds average item price per merchant' do
      expect(@sales_analyst.average_item_price_for_merchant(12334159)).to be_a(BigDecimal)
      expect(@sales_analyst.average_item_price_for_merchant(12334105).to_f).to eq(16.66)
    end

    it 'finds average price across all merchants' do
      expect(@sales_analyst.average_average_price_per_merchant).to be_a(BigDecimal)
      expect(@sales_analyst.average_average_price_per_merchant).to eq(350.29)
    end

    it 'finds items two STD above average price' do
      expect(@sales_analyst.golden_items).to be_a(Array)
      expect(@sales_analyst.golden_items.length).to eq(5)
      expect(@sales_analyst.golden_items.first.class).to eq(Item)
    end

  end

end
