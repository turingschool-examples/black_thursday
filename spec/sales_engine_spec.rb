require "./lib/sales_engine"
require "./lib/item_repository"
require "./lib/merchant_repository"

RSpec.describe SalesEngine do
  it "exists" do
    sales_engine = SalesEngine.from_csv(
      {
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    }
    )
    expect(sales_engine).to be_instance_of SalesEngine
  end
end
