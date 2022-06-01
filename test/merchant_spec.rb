require './lib/merchant'

RSpec.describe Merchant do
  before :each do
    @merchant = Merchant.new({:id => 5, :name => "Turing School"})
  end

  describe "#initialize" do
    it "is a Merchant" do
      expect(@merchant).to be_a Merchant
    end

    it "has an ID" do
      expect(@merchant.id).to eq 5
    end

    it "has a name" do
      expect(@merchant.name).to eq "Turing School"
    end
  end
end
