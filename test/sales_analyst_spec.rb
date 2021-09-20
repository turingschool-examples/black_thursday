require './lib/sales_engine'
require './lib/item'
require 'bigdecimal'
require 'bigdecimal/util'
require 'rspec'
require 'csv'
require './lib/merchantrepository'
require './lib/merchant'
require './lib/sales_analyst'
require './lib/invoice.rb'
require './lib/invoicerepository.rb'

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

  xit 'calculates average items per merchant' do
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


  xit 'shows merchants that sell a lot of items' do
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

    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    ir = se.items
    mr = se.merchants
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst.average_item_price_for_merchant(12334159)).to eq(0.315e4)
    expect(sales_analyst.average_item_price_for_merchant(12336819)).not_to eq(0.315e4)

  end

  xit 'shows the average average price of merchant items' do

    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    ir = se.items
    mr = se.merchants
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst.average_average_price_per_merchant).to eq(0.350294697495132e5)
  end

  it 'can list golden items' do

    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    ir = se.items
    mr = se.merchants
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst.golden_items.count).to eq(ir.find_all_by_price_in_range(615567.11, Float::INFINITY).count)

  end

  xit 'can find the average invoices per merchant' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    ir = se.items
    mr = se.merchants
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst.average_invoices_per_merchant).to eq(10.49)
  end

  xit 'can find the standard deviation invoices per merchant' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    ir = se.items
    mr = se.merchants
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(3.29)
  end

  xit 'can find the standard deviation invoices per merchant' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => './data/invoices.csv'
    })
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst.invoice_status(:pending)).to eq(29.55)
  end

  xit ''



end
