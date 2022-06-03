require "./lib/sales_engine"
require "./lib/sales_analyst"
# require "./lib/item_repository"
require "./lib/merchant_repository"

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
