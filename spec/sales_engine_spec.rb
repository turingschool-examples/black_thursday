require './lib/sales_engine'

RSpec.describe SalesEngine do
  xit "exists" do
    se = SalesEngine.new({:items => "here are items", :merchants => "here are merchants"})

    expect(se).to be_a(SalesEngine)
  end

  xit "can access items and merchants" do
    se = SalesEngine.new({:items => "here are items", :merchants => "here are merchants"})

    expect(se.items).to eq("here are items")
    expect(se.merchants).to eq("here are merchants")
  end

  it "can pull items and merchants from csv" do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    expect(se.items).to be_a(ItemRepository)
    expect(se.merchants).to be_a(MerchantRepository)
    expect(se.items.all.count).to eq(475)
    expect(se.merchants.all.count).to eq(1367)
  end
end
