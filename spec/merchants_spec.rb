require 'rspec'
require './lib/merchants'

RSpec.describe Merchant do

  se = SalesEngine.from_csv({
  :merchants => "./data/merchants.csv"
  })
  mr = se.merchants

  context "Merchant" do
    it "can return id" do
      merchant = mr.all[0]
      expect(merchant.id).to eq(12334105)
    end
    it "can return name" do
      first_merchant = mr.all[0]
      expect(first_merchant.name).to eq("Shopin1901")
      second_merchant = mr.all[1]
      expect(second_merchant.name).to eq("Candisart")
    end
  end

end
