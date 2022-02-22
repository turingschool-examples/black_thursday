require_relative '../lib/merchant'

RSpec.describe Merchant do
  describe "Iteration 1" do
    it "exits" do
      m = Merchant.new({:id => 5, :name => "Turing School"})
      expect(m).to be_an_instance_of(Merchant)
    end

    it "has an id" do
      m = Merchant.new({:id => 5, :name => "Turing School"})
      expect(m.id).to eq(5)
    end

    it "has a name" do
      m = Merchant.new({:id => 5, :name => "Turing School"})
      expect(m.name).to eq("Turing School")
    end
  end

end
