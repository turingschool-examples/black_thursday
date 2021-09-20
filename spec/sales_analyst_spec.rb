require './lib/sales_analyst'
require 'csv'

RSpec.describe SalesAnalyst do

  #How to access stuff:
  # => sales_analyst.analyst_items.all.count

  it 'exists' do
    sales_engine = SalesEngine.new({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
  end

  it 'average_items_per_merchant' do
    sales_engine = SalesEngine.new({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_items_per_merchant).to eq 2.88
  end

  it 'average_items_per_merchant_standard_deviation' do
    sales_engine = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq 3.26
  end

  it 'merchants_with_high_item_count' do
    sales_engine = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.merchants_with_high_item_count.count).to eq 52
  end

  it 'average_item_price_for_merchant given a merchant id' do
    sales_engine = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_item_price_for_merchant("12334105")).to eq 1665.67
  end

  it 'average_average_price_per_merchant' do
    sales_engine = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_average_price_per_merchant).to eq 35029.47
  end

  it 'golden_items' do
    sales_engine = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.golden_items.count).to eq 5
  end
end
