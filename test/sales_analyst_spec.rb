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
  xit 'exists' do
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

    expect(sales_analyst.merchants_with_high_item_count.count).to eq(52)
  end

  xit 'shows average price of merchant items' do

    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    ir = se.items
    mr = se.merchants
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst.average_item_price_for_merchant(12334159)).to eq(0.315e2)
    expect(sales_analyst.average_item_price_for_merchant(12336819)).not_to eq(0.315e2)

  end

  xit 'shows the average average price of merchant items' do

    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    ir = se.items
    mr = se.merchants
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst.average_average_price_per_merchant).to eq(0.350294697495132e3)
  end

  xit 'can list golden items' do

    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    ir = se.items
    mr = se.merchants
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst.golden_items.count).to eq(ir.find_all_by_price_in_range(6155.6711, Float::INFINITY).count)

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

  xit 'can find the percentage of invoices by status' do
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

  xit 'can tell us who are the merchants with a high number of invoices' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => './data/invoices.csv'
    })
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst.top_merchants_by_invoice_count.count).to eq(4)

  end

  xit 'can tell us who are the merchants with a low number of invoices' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => './data/invoices.csv'
    })
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst.bottom_merchants_by_invoice_count.count).to eq(361)

  end

  xit 'can group invoices into a hash by day of week' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => './data/invoices.csv'
    })
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = SalesAnalyst.new
    expect(sales_analyst.invoices_per_day["Monday"].count).to eq(696)
    expect(sales_analyst.invoices_per_day["Tuesday"].count).to eq(692)

  end

  xit 'can tell the average number of invoices on a day of the week' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => './data/invoices.csv'
    })
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst.invoices_per_day_count["Monday"]).to eq(696)

  end

  xit 'can find the average invoices per day' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => './data/invoices.csv'
    })
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst.average_invoices_per_day).to eq(712.14)

  end

  xit 'can find the average invoices per day standard deviation' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => './data/invoices.csv'
    })
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst.average_invoices_per_day_standard_deviation).to eq(0.63)

  end

  xit 'can find the average invoices per day standard deviation' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => './data/invoices.csv'
    })
    ir = se.items
    mr = se.merchants
    inr = se.invoices
    sales_analyst = SalesAnalyst.new

    expect(sales_analyst.top_days_by_invoice_count).to eq(["Wednesday", "Thursday", "Saturday"])

  end

end
