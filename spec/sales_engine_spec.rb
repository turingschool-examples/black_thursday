require "./lib/sales_engine"
require "./lib/item_repository"
require "./lib/merchant_repository"

RSpec.describe SalesEngine do
  before :each do
    @sales_engine = SalesEngine.from_csv(
      {
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
      }
    )
  end
  it "exists" do
    expect(@sales_engine).to be_instance_of SalesEngine
  end

  it "can return an array of all items" do
    expect(@sales_engine.item_repository).to be_instance_of ItemRepository
  end

  it "can return an array of all merchants" do
    expect(@sales_engine.merchant_repository).to be_instance_of MerchantRepository
  end
end
