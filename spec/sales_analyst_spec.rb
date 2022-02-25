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
      expect(@sales_analyst.merchants_with_high_item_count).to to_include(Merchant)
    end

  end

end
