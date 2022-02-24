require './lib/sales_engine'

RSpec.describe SalesEngine do
  it "exists" do
    se = SalesEngine.new({:items => "here are items", :merchants => "here are merchants"})

    expect(se).to be_a(SalesEngine)
  end

  it "can access items and merchants" do
    se = SalesEngine.new({:items => "here are items", :merchants => "here are merchants"})

    expect(se.items).to eq("here are items")
    expect(se.merchants).to eq("here are merchants")
  end
end
