require './lib/sales_engine'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/sales_analyst'
require 'pry'

describe SalesAnalyst do

  sales_engine = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
                            })
  sales_analyst = sales_engine.analyst

  it "exists" do
    expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
  end

  it "can list all items by merchant ID" do
    expect(sales_analyst.list_all_items_by_merchant.length).to eq(475)
    expect(sales_analyst.list_all_items_by_merchant[3].length).to eq(20)
    expect(sales_analyst.list_all_items_by_merchant[1].length).to eq(6)
    expect(sales_analyst.list_all_items_by_merchant[5].length).to eq(1)
  end

  it "can determine the average items per merchant" do
    expect(sales_analyst.average_items_per_merchant).to eq(2.88)

  end

  it "can determine the standard deviation of items per merchant" do
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

  it "can determine merchants with high item counts" do
    expect(sales_analyst.merchants_with_high_item_count[0].name).to eq("FlavienCouche")
    expect(sales_analyst.merchants_with_high_item_count[2].name).to eq("BowlsByChris")
    expect(sales_analyst.merchants_with_high_item_count[35].name).to eq("BoDaisyClothing")
  end

  it "can determine average item price for merchant" do
    expect(sales_analyst.average_item_price_for_merchant(12334105)).to eq(16.66)
    expect(sales_analyst.average_item_price_for_merchant(12334105)).to be_a(BigDecimal)
  end

  it 'can determine the average of the average item price by merchant' do
    a = sales_analyst.average_average_price_per_merchant
    expect(a).to eq 350.29
    expect(a.class).to eq BigDecimal
  end

  it 'gets the average price of all items' do
    a = sales_analyst.average_item_price
    expect(a).to eq 251.06
    expect(a.class).to eq BigDecimal
  end

end
