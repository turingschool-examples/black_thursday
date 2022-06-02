require "./lib/sales_engine"

require "./lib/item_repository"
require "./lib/merchant_repository"

#You may need to add more `expect` lines to each test to make it more robust...!
RSpec.describe SalesEngine do
  it "exists" do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    expect(sales_engine).to be_instance_of SalesEngine
  end

  it "can return an array of all items" do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    expect(sales_engine.item_repository).to be_instance_of ItemRepository
  end

  it "can return an array of all merchants" do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    expect(sales_engine.merchant_repository).to be_instance_of MerchantRepository

  end

end
