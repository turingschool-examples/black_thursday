require 'rspec'
require './lib/merchants'

RSpec.describe Merchant do

  se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  })
  mr = se.merchants

  context "Merchant" do
    it "#id returns the merchant id" do
      merchant = mr.all.first
      expect(merchant.id).to eq 12334105
    end
    it "#name returns the merchant name" do
      merchant_one = mr.all.first
      expect(merchant_one.name).to eq "Shopin1901"
      merchant_two = mr.all.last
      expect(merchant_two.name).to eq "CJsDecor"
    end
  end

end
