require "Rspec"
require "./lib/merchant"

describe Merchant do
  before :each do
    @m = Merchant.new({:id => 5, :name => "Turing School"})
  end

  it "is a Merchant" do
    expect(@m).to be_a Merchant
  end

  it "#id" do
    expect(@m.id).to eq 5
  end

  it "#name" do
    expect(@m.name).to eq  "Turing School"
  end
end