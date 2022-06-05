require './lib/sales_analyst'
require './lib/sales_engine'
require 'pry'

RSpec.describe SalesAnalyst do
  it "exists" do
    sales_engine = SalesEngine.new("./data/items.csv", "./data/merchants.csv")
    sales_analyst = sales_engine.analyst
    expect(sales_analyst).to be_a SalesAnalyst
  end
  it "calculates average_items_per_merchant" do
    sales_engine = SalesEngine.new("./data/items.csv", "./data/merchants.csv")
    sales_analyst = sales_engine.analyst

    expect(sales_analyst.average_items_per_merchant).to be_a Float
    expect(sales_analyst.average_items_per_merchant).to eq 2.88
  end

  it "calculates average_item_price_for_merchant" do
    sales_engine = SalesEngine.new("./data/items.csv", "./data/merchants.csv")
    sales_analyst = sales_engine.analyst

    expect(sales_analyst.average_item_price_for_merchant(12334185)).to be_a Float
    expect(sales_analyst.average_item_price_for_merchant(12334185)).to eq 1078.33
  end

  it "calculates standard dev" do
    sales_engine = SalesEngine.new("./data/items.csv", "./data/merchants.csv")
    sales_analyst = sales_engine.analyst

    expect(sales_analyst.average_items_per_merchant_standard_deviation).to be_a Float
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq 3.26
  end
  it "sorts merchants_with_high_item_count" do
    sales_engine = SalesEngine.new("./data/items.csv", "./data/merchants.csv")
    sales_analyst = sales_engine.analyst

    expect(sales_analyst.merchants_with_high_item_count).to be_a Array
    expect(sales_analyst.merchants_with_high_item_count.count).to eq(52)
    expect(sales_analyst.merchants_with_high_item_count.first).to be_a Merchant
    expect(sales_analyst.merchants_with_high_item_count.first.id).to eq(12334195)
  end

  it "can sum all of the averages and find the average price across all merchants" do
    sales_engine = SalesEngine.new("./data/items.csv", "./data/merchants.csv")
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_average_price_per_merchant).to be_a Float
   expect(sales_analyst.average_average_price_per_merchant).to eq(35029.47)
  end


end
