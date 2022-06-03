require "./lib/sales_engine"
require "./lib/sales_analyst"
require "./lib/merchant_repository"


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

  it "calculates an average price for a merchant" do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    sales_analyst = sales_engine.analyst
    # sales_analyst.items.find_all_by_merchant_id(12334105)
    expect(sales_analyst.items.find_all_by_merchant_id(12334105).count).to eq(3)
    expect(sales_analyst.average_item_price_for_merchant(12334105)).to eq(16.66)
  end
  it "calculates the average average price per merchant (average of all merchants price)" do
     sales_engine = SalesEngine.from_csv({
       :items => "./data/items.csv",
       :merchants => "./data/merchants.csv"
     })

       sales_analyst = sales_engine.analyst
       expect(sales_analyst.average_average_price_per_merchant).to eq(350.29)
       end
end
