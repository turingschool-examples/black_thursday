require 'pry'
require 'simplecov'
require 'rspec'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'

SimpleCov.start

RSpec.describe SalesAnalyst do
  it 'exists' do
    sa = SalesAnalyst.new(1, 2)
    expect(sa).to be_a(SalesAnalyst)
  end

  xit 'what is the average items per merchant' do
    sales_engine = SalesEngine.from_csv({ :items => "./data/items.csv", :merchants => "./data/merchants.csv" })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it 'what is the standard deviation' do
    sales_engine = SalesEngine.from_csv({ :items => "./data/items.csv", :merchants => "./data/merchants.csv" })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  xit 'which merchants have above one st. dev. avg products offered' do
    sales_engine = SalesEngine.from_csv({ :items => "./data/items.csv", :merchants => "./data/merchants.csv" })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.merchants_with_high_item_count).to eq("ummmmm i don't know")
  end

  xit 'what is the avg item price for a merchant' do
    sales_engine = SalesEngine.from_csv({ :items => "./data/items.csv", :merchants => "./data/merchants.csv" })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_item_price_for_merchant(12334159)).to eq("ummmmm i don't know")
  end

  xit 'what is the avg avg price for a merchant' do
    sales_engine = SalesEngine.from_csv({ :items => "./data/items.csv", :merchants => "./data/merchants.csv" })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_average_price_for_merchant).to eq("ummmmm i don't know")
  end

  xit 'what items are over two st. devs above avg item price' do
    sales_engine = SalesEngine.from_csv({ :items => "./data/items.csv", :merchants => "./data/merchants.csv" })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.golden_items).to eq("ummmmm i don't know")
  end
end
