require "./lib/sales_engine"
require "./lib/item"
require("./lib/merchant")
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
    expect(sales_engine.merchant_repository).to(be_instance_of(MerchantRepository))
    expect(sales_engine.merchant_repository.all).to(be_a(Array))
    expect(sales_engine.merchant_repository.all.length).to(eq(475))
  end
end
