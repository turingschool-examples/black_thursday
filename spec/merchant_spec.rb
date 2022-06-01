require './lib/merchant'

RSpec.describe Merchant do
  it "exists" do
    merchant = Merchant.new(1, "Bob's Burgers")
    expect(merchant).to  be_instance_of (Merchant)
  end

  it "can return a name and id" do
    merchant = Merchant.new(:id => 1, :name => "Bob's Burgers")
    expect(merchant.id).to eq(1)
    expect(merchant.name).to eq("Bob's Burgers")
  end
end
