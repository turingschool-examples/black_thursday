require "./lib/sales_engine"
require "./lib/item_collection"
require "./lib/merchant_collection"

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

    expect(sales_engine.item_collection).to be_instance_of ItemCollection
  end

  it "can return an array of all instances" do
    sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    expect(sales_engine.merchant_collection).to be_instance_of MerchantCollection
  end

  it 'can return child instances' do
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    ic = se.item_collection
    item = ic.find_by_name("Thukdokhin wax cord")

    expect(ic).to be_a(ItemCollection)
    expect(item.id).to eq("263404585")
  end

end
