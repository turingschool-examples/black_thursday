require_relative "../lib/sales_analyst"
require_relative "../lib/sales_engine"
require 'rspec'

describe SalesAnalyst do
  before :each do
    @se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv'
    })
    @sa = SalesAnalyst.new(@se.items, @se.merchants)
  end

  it '#average_item_per_merchant' do

    expect(@sa.average_item_per_merchant).to eq(2.88)
  end

  it '#average_item_per_merchant_standard_deviation' do

    expect(@sa.average_item_per_merchant_standard_deviation).to eq(3.26)
  end
end