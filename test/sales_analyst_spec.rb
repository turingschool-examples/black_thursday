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

  xit 'calculates standard deviation' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    ir = se.items
    mr = se.merchants
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end


  it 'shows merchants that sell a lot of items' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    ir = se.items
    mr = se.merchants
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst.merchants_with_high_item_count.count).to eq(42)
  end

  xit 'shows average price of merchant items' do
    #test for our next method
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    ir = se.items
    mr = se.merchants
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst.average_item_price_for_merchant(12334159)).to eq("num")
  end

end
