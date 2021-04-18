require './lib/sales_analyst'
require './lib/sales_engine'
require './lib/items'
require './lib/merchants'
require './items_repo'
require './merchants_repo'
require 'rspec'

RSpec.describe SalesAnalyst do

  context 'Instanstiation' do
    it 'exists' do
      se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
      sales_analyst = se.analyst

      expect(sales_analyst).to be_instance_of(SalesAnalyst)
    end
  end

  context 'methods' do

    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    sales_analyst = se.analyst

    it 'can return average items per merchant' do
      expect(sales_analyst.average_items_per_merchant).to eq(2.88)
    end

    it 'can return standard deviation of items per merchant' do
      expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
    end

    xit "can return merchants with the most items" do
      expected = sales_analyst.merchants_with_high_item_count

      expect(expected.length).to eq(52)
      expect(expected.first.class).to eq(Merchant)
      expect(expected.class).to eq(Array)
    end

    it 'can find the average price of a merchants items' do

      expect(sales_analyst.average_item_price_for_merchant(12334105).class).to eq(BigDecimal)
      expect(sales_analyst.average_item_price_for_merchant(12334105)).to eq(0.1666e2)
    end

    it 'can find the average of average price' do
      expect(sales_analyst.average_average_price_per_merchant.class).to eq(BigDecimal)
      expect(sales_analyst.average_average_price_per_merchant).to eq(0.35029e3)
    end

    it 'can return items 2 standard deviations above average item price' do
      expect(sales_analyst.golden_items.class).to eq(Array)
      expect(sales_analyst.golden_items.length).to eq(5)
    end
  end

end
