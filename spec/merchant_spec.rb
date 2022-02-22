require_relative 'merchant'

RSpec.describe Merchant do
  describe "Iteration 1" do
    it "exits" do
      m = Merchant.new({:id => 5, :name => "Turing School"})
      expect(m).to be_an_instance_of(Merchant)
    end
  end

end
