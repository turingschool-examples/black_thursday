require './lib/merchant'

RSpec.describe Merchant do
  let(:merchant) {Merchant.new({:id => 5, :name => "Turing School"})}

  it "exists" do
    expect(merchant).to be_an(Merchant)
  end

  it "has attributes" do
    expect(merchant.name).to eq("Turing School")
    expect(merchant.id).to eq(5)
  end

end
