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

  xit 'returns difference between number of items for specified merchant and average items' do

    expect(@sales_analyst.difference_between_merchant_items_and_mean(12334135)).to eq(1.88)

    expect(@sales_analyst.difference_between_merchant_items_and_mean(12334315)).to eq(2.12)
  end

  xit 'can return sum of differences squared' do
    expect(@sales_analyst.sum_of_differences_squared).to eq(11338.44)
    # I don't feel 100% confident in this
  end

  it "can determine standard deviation" do
    expect(@sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  it "can determine which merchant sold the most items?" do
    expect(@sales_analyst.merchants_with_high_item_count).to be_instance_of(Array)
  end

  it "can give us avg price of given merchants items" do
    expect(@sales_analyst.average_item_price_for_merchant(12334159)).to be_instance_of(bigdecimal)
  end
  #compare against harness
end
