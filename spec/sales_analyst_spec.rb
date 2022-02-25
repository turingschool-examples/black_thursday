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
    # binding.pry
  end

  it "can list all items by merchant ID" do
    expect(sales_analyst.list_all_items_by_merchant.length).to eq(475)
    expect(sales_analyst.list_all_items_by_merchant[3].length).to eq(20)
    expect(sales_analyst.list_all_items_by_merchant[1].length).to eq(6)
    expect(sales_analyst.list_all_items_by_merchant[5].length).to eq(1)
  end

  it "can determine the standard deviation of items per merchant" do
    expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(3.26)
  end

end
