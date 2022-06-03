require "./lib/sales_engine"
require "./lib/item_repository"
require "./lib/merchant_repository"

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
    expect(sales_engine.merchant_repository.all).to be_instance_of Array
    expect(sales_engine.item_repository).to be_instance_of ItemRepository
    expect(sales_engine.item_repository.all).to be_instance_of Array
  end

  it "can find merchants and items by name" do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    expect(sales_engine.merchant_repository.find_by_name("Shopin1901")).to be_a Merchant

    expect(sales_engine.item_repository.find_by_name("Vogue Paris Original Givenchy 2307")).to be_a Item
  end



end
