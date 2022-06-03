require "./lib/sales_engine"
require "./lib/sales_analyst"
# require "./lib/item_repository"
# require "./lib/merchant_repository"

#You may need to add more `expect` lines to each test to make it more robust...!
RSpec.describe SalesAnalyst do
  it "exists" do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    sales_analyst = sales_engine.analyst

    expect(sales_analyst).to be_a(SalesAnalyst)
  end

  it 'returns the average items per merchant' do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    sales_analyst = sales_engine.analyst

    expect(sales_analyst.average_items_per_merchant).to eq(2.88)
  end

  it 'return a standard deviation of the number of items per merchant' do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    sales_analyst = sales_engine.analyst

    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  it 'checks for merchants with high item count' do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    sales_analyst = sales_engine.analyst

    expect(sales_analyst.merchants_with_high_item_count).to be_a(Array)
    expect(sales_analyst.merchants_with_high_item_count.length).to eq(52)
  end

  it 'return golden items' do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    sales_analyst = sales_engine.analyst

    expect(sales_analyst.golden_items).to be_a(Array)
    expect(sales_analyst.golden_items.length).to eq(5)
  end

  it 'can calculate standard_deviation'do
  sales_engine = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => "./data/merchants.csv"
  })

  sales_analyst = sales_engine.analyst

  expect(sales_analyst.standard_deviation([3,4,5],4)).to eq(1.0)
  end
end
