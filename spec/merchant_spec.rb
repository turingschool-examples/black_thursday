require "./lib/merchant"
require "pry"

RSpec.describe Merchant do
  it "exists" do
    m = Merchant.new({id: 5, name: "Turing School"})
    expect(m).to be_an_instance_of(Merchant)
  end

  it " has an id" do
    m = Merchant.new({id: 5, name: "Turing School"})
    expect(m.merchant_attributes[:id]).to eq(5)
  end

  it "has a name" do
    m = Merchant.new({id: 5, name: "Turing School"})
    expect(m.merchant_attributes[:name]).to eq("turing school")
  end
end
