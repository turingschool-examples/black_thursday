require './lib/sales_engine'

RSpec.describe SalesEngine do

  before :each do
    @sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
  end

  it "exists" do
    expect(@sales_engine).to be_a(SalesEngine)
  end

  xit "can return array of items" do
    expect(@sales_engine.item_repository).to be_a(ItemRepository)
    expect(@sales_engine.item_repository.all).to be_a(Array)
    expect(@sales_engine.item_repository.all.first).to be_a(Item)
    # to be continued...
  end

  xit "can return array of merchants" do
    expect(@sales_engine.merchant_repository).to be_a(MerchantRepository)
    expect(@sales_engine.merchant_repository.all).to be_a(Array)
    expect(@sales_engine.merchant_repository.all.length).to eq(475)
    expect(@sales_engine.merchant_repository.all.first).to be_a(Merchant)
    expect(@sales_engine.merchant_repository.all.first.id).to eq("12334105")
  end

end
