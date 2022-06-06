require "./lib/sales_engine"
require "./lib/item"
require './lib/item_repository'
require "./lib/merchant"
require "./lib/merchant_repository"


RSpec.describe(SalesEngine) do
  it("#exists") do
    sales_engine = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    expect(sales_engine).to(be_instance_of(SalesEngine))
  end

  it("#can return an arrray of all items") do
    sales_engine = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    expect(sales_engine.item_repository).to(be_instance_of(ItemRepository))
  end

  it("#can return an array of all merchants") do
    sales_engine = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    expect(sales_engine.merchant_repository).to be_a MerchantRepository
    expect(sales_engine.merchant_repository.all).to be_instance_of Array
    expect(sales_engine.merchant_repository.all.length).to eq 475
  end

  it "can create an instance of salesanalyst" do
    sales_engine = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    sales_analyst = sales_engine.analyst
    expect(sales_analyst).to be_a(SalesAnalyst)
  end
end
