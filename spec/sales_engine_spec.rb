require 'pry'
require './lib/sales_engine'
require 'rspec'
require 'simplecov'
require './lib/item_repository'
require './lib/merchant_repository'

SimpleCov.start

RSpec.describe SalesEngine do
  it 'exists' do
    se = SalesEngine.new({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    expect(se.class).to eq(SalesEngine)
  end

  it 'has an items_csv_object attribute by default' do
    se = SalesEngine.new({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    expect(se.items_csv_object).to eq("./data/items.csv")
  end

  it 'has an merchants_csv_object attribute by default' do
    se = SalesEngine.new({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    expect(se.merchants_csv_object).to eq("./data/merchants.csv")
  end

  it 'Sets attributes to CSV objects' do
    se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    expect(se.items_csv_object.class).to eq(CSV::Table)
    expect(se.merchants_csv_object.class).to eq(CSV::Table)
  end

  it 'items method returns instance of ItemRepo... with instances loaded' do
    se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    # binding.pry
    expect(se.items.class).to eq(ItemRepository)
  end

  it 'merchants method returns instance of MerchantsRepo... with instances loaded' do
    se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    expect(se.merchants.class).to eq(MerchantRepository)
  end









end
