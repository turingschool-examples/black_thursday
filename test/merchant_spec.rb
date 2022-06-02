require './lib/merchant'

RSpec.describe Merchant do

  before :each do
    @merchant = Merchant.new({id: 5, name: "Turing School"})
  end

  it "exists" do
    expect(@merchant).to be_a(Merchant)
  end

  it "has an id" do
    expect(@merchant.id).to eq(5)
  end

  it "has a name" do
    expect(@merchant.name).to eq("Turing School")
  end

end
