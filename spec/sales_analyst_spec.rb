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

  it 'groups items by merchant id' do
    sales_engine = SalesEngine.from_csv({ :items => "./data/items.csv", :merchants => "./data/merchants.csv" })
    sales_analyst = sales_engine.analyst
    sales_analyst.group_items_by_merchant_id
    expect(sales_analyst.merchant_items_hash.count).to eq(475)
    expect(sales_analyst.merchant_items_hash.class).to eq(Hash)
  end

  it 'makes a list of the number of items offered by each merchant' do
    sales_engine = SalesEngine.from_csv({ :items => "./data/items.csv", :merchants => "./data/merchants.csv" })
    sales_analyst = sales_engine.analyst
    sales_analyst.items_per_merchant
    expect(sales_analyst.num_items_per_merchant.class).to be(Array)
    expect(sales_analyst.num_items_per_merchant.count).to be(475)
    expect(sales_analyst.num_items_per_merchant.sum).to be(1367)
  end

  it 'what is the average items per merchant' do
    sales_engine = SalesEngine.from_csv({ :items => "./data/items.csv", :merchants => "./data/merchants.csv" })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it 'collects squared differences of each item count and mean of item counts' do
    sales_engine = SalesEngine.from_csv({ :items => "./data/items.csv", :merchants => "./data/merchants.csv" })
    sales_analyst = sales_engine.analyst
    sales_analyst.square_differences
    expect(sales_analyst.set_of_square_differences.count).to eq(475)
    expect(sales_analyst.set_of_square_differences.class).to eq(Array)
    expect(sales_analyst.set_of_square_differences[0].class).to eq(Float)
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
