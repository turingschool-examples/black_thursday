require "./lib/sales_engine"
require "./lib/sales_analyst"
require "./lib/merchant_repository"
require "./lib/invoice_repository"
require "./lib/item_repository"


RSpec.describe SalesAnalyst do
  it "exists" do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst).to be_a(SalesAnalyst)
  end

  it 'returns the average items per merchant' do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it "count the total amount of items a merchant has" do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.count_merchants_items(12334105)).to eq(3)
  end

  it "finds all items a merchant has by ID and makes them into an array" do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.price_array(12334105)).to eq([29.99, 9.99, 9.99])
  end

  it "retrieves array of prices and number of items and calculates an average price for a merchant" do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = sales_engine.analyst
    expect(sales_analyst.average_item_price_for_merchant(12334105)).to eq(16.66)
  end

  it 'return a standard deviation of the number of items per merchant' do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = sales_engine.analyst

    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  it 'checks for merchants with high item count' do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = sales_engine.analyst

    expect(sales_analyst.merchants_with_high_item_count).to be_a(Array)
    expect(sales_analyst.merchants_with_high_item_count.length).to eq(52)
  end

  it 'return golden items' do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    sales_analyst = sales_engine.analyst

    expect(sales_analyst.golden_items).to be_a(Array)
    expect(sales_analyst.golden_items.length).to eq(5)
  end

  it 'can calculate standard_deviation'do
  sales_engine = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv"
  })
  sales_analyst = sales_engine.analyst

  expect(sales_analyst.standard_deviation([3,4,5],4)).to eq(1.0)
  end

  it "calculates the average average price per merchant (average of all merchants price)" do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })

       sales_analyst = sales_engine.analyst
       expect(sales_analyst.average_average_price_per_merchant).to eq(350.29)
       end
end
