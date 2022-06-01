require './lib/merchant'

describe Merchant do
  before(:each) do
    @m = Merchant.new({:id => 5, :name => "Turing School"})
  end

  it "is an instance of merchant" do
    expect(@m).to be_a(Merchant)
  end

  it "can give you the id" do
    expect(@m.id).to eq(5)
  end

  it "can give you the name" do
    expect(@m.name).to eq("Turing School")
  end

end
