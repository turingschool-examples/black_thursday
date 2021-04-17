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

    it "can return merchants with the most items" do
      expected = sales_analyst.merchants_with_high_item_count

      expect(expected.length).to eq(52)
      expect(expected.first.class).to eq(Merchant)
      expect(expected.class).to eq(Array)
    end
  end

  # context '#merchants_with_high_item_count' do
  #   xit 'can return merchants with number of items higher than standard deviation' do
  #     se = SalesEngine.from_csv({
  #     :items     => "./data/items.csv",
  #     :merchants => "./data/merchants.csv",
  #     })
  #
  #     sales_analyst = SalesEngine.analyst
  #     mr = se.merchants
  #     ir = se.items
  #
  #     expect(sales_analyst.merchants_with_high_item_count.class).to eq(Array) #Use mock or stub
  #   end
  # end
  #
  # context '#average_item_price_for_merchant' do
  #   xit 'can find the average price of a merchants items' do
  #     se = SalesEngine.from_csv({
  #     :items     => "./data/items.csv",
  #     :merchants => "./data/merchants.csv",
  #     })
  #
  #     sales_analyst = SalesEngine.analyst
  #     mr = se.merchants
  #     ir = se.items
  #
  #     expect(sales_analyst.average_item_price_for_merchant(12334159.class)).to eq(BigDecimal)
  #   end
  # end
  #
  # context '#average_average_price_per_merchant' do
  #   xit 'can find the average of average price' do
  #     se = SalesEngine.from_csv({
  #     :items     => "./data/items.csv",
  #     :merchants => "./data/merchants.csv",
  #     })
  #
  #     sales_analyst = SalesEngine.analyst
  #     mr = se.merchants
  #     ir = se.items
  #
  #     expect(sales_analyst.average_average_price_per_merchant.class).to eq(BigDecimal)
  #   end
  # end
  #
  # context '#golden_items' do
  #   xit 'can return items 2 standard deviations above average item price' do
  #     se = SalesEngine.from_csv({
  #     :items     => "./data/items.csv",
  #     :merchants => "./data/merchants.csv",
  #     })
  #
  #     sales_analyst = SalesEngine.analyst
  #     mr = se.merchants
  #     ir = se.items
  #
  #     expect(sales_analyst.golden_items.class).to eq(Array)
  #   end
  # end
end
