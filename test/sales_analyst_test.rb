require 'simplecov'
SimpleCov.start
require './lib/merchant'
require './lib/merchant_repository'
require './lib/sales_analyst'
require './lib/sales_engine'
require './lib/item'
require './lib/item_repository'
require 'bigdecimal'
require 'rspec'

RSpec.describe SalesAnalyst do
  before :each do
    @sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
    @sales_analyst = @sales_engine.analyst
  end

  it "exists" do
    expect(@sales_analyst).to be_instance_of(SalesAnalyst)
  end

  it "can determine average items" do
    expect(@sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it "can determine standard deviation" do
    expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  it "can determine which merchant sold the most items?" do
    expect(@sales_analyst.merchants_with_high_item_count).to be_instance_of(Array)
  end

  it "can give us avg price of given merchants items" do
    expect(@sales_analyst.average_item_price_for_merchant(12334159)).to eq(3150)
    #be_instance_of(bigdecimal)
  end

  it "can return sum of given merchants item prices" do
    expect(@sales_analyst.price_sum_helper(12334159)).to eq(31500)
  end

    #compare against harness
  it "can sum all of the averages and find the average price across all merchants" do
    expect(sales_analyst.average_average_price_per_merchant).to eq(0)
  end

end
