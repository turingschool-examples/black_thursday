require './lib/sales_engine'
require './lib/item'
require 'bigdecimal'
require 'bigdecimal/util'
require 'rspec'
require 'csv'
require './lib/merchantrepository'
require './lib/merchant'
require './lib/sales_analyst'

describe SalesAnalyst do
  it 'exists' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    ir = se.items
    mr = se.merchants
    sales_analyst = SalesAnalyst.new

    expect(ir).to be_a(ItemRepository)
    expect(mr).to be_a(MerchantRepository)
    expect(sales_analyst).to be_a(SalesAnalyst)

  end

  it 'calculates average items per merchant' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    ir = se.items
    mr = se.merchants
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it 'calculates standard deviation' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    ir = se.items
    mr = se.merchants
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end
end
