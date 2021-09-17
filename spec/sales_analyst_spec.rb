require 'rspec'
require './lib/sales_analyst'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchants_repository'
require './lib/items'
require './lib/item_repository'
require 'csv'

describe SalesAnalyst do

  it 'exists' do
    se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
    sales_analyst = se.analyst(se.items, se.merchants)

    expect(sales_analyst).to be_a(SalesAnalyst)
  end
end
