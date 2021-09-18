require 'rspec'
require 'csv'
require 'SimpleCov'
require 'BigDecimal'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchants_repository'
require './lib/items'
require './lib/item_repository'
require './lib/sales_analyst'

describe SalesAnalyst do

  describe '#initialize' do
    it 'creates an instance of SalesAnalyst' do
      se = SalesEngine.new({
        :items => './data/items.csv',
        :merchants => './data/merchants.csv'
        })
      sales_analyst = se.analyst(se.items, se.merchants)

      expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
    end

    it 'has readable attributes' do
      se = SalesEngine.new({
        :items => './data/items.csv',
        :merchants => './data/merchants.csv'
        })
      sales_analyst = se.analyst(se.items, se.merchants)

      expect(sales_analyst.items).to be_an(Array)
      expect(sales_analyst.merchants).to be_an(Array)
      expect(sales_analyst.merch_item_hash).to be_a(Hash)
    end
  end

  describe '#average_items_per_merchant' do
    it 'returns the average number of items for sale per merchant' do
      se = SalesEngine.new({
        :items => './data/items.csv',
        :merchants => './data/merchants.csv'
        })
      sales_analyst = se.analyst(se.items, se.merchants)

      expect(sales_analyst.average_items_per_merchant).to eq(2.88)
    end
  end

  describe '#average_items_per_merchant_standard_deviation' do
    it 'returns the standard deviation of items per merchant' do
      se = SalesEngine.new({
        :items => './data/items.csv',
        :merchants => './data/merchants.csv'
        })
      sales_analyst = se.analyst(se.items, se.merchants)

      expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
    end
  end

  describe '#merchants_with_high_item_count' do
    it 'returns merchants with item counts above 1 standard deviation above mean' do
      se = SalesEngine.new({
        :items => './data/items.csv',
        :merchants => './data/merchants.csv'
        })
      sales_analyst = se.analyst(se.items, se.merchants)

      expect(sales_analyst.merchants_with_high_item_count).to be_an(Array)
    end
  end

  describe '#average_item_price_for_merchant' do
    it 'returns the average price of items for a particular merchant' do
      se = SalesEngine.new({
        :items => './data/items.csv',
        :merchants => './data/merchants.csv'
        })
      sales_analyst = se.analyst(se.items, se.merchants)

      expect(sales_analyst.average_item_price_for_merchant(12334159)).to be_a(BigDecimal)
    end
  end

  describe "#average_average_item_price_for_merchant" do
    it 'returns the average price across all merchants' do
      se = SalesEngine.new({
        :items => './data/items.csv',
        :merchants => './data/merchants.csv'
        })
      sales_analyst = se.analyst(se.items, se.merchants)

      expect(sales_analyst.average_average_item_price_for_merchant).to be_a(BigDecimal)
    end
  end

end
