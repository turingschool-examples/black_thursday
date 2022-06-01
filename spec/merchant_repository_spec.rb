require 'RSpec'
# require './lib/sales_engine'
# require './lib/item_repository'
require './lib/merchant_repository'

describe MerchantRepository do
  before :each do
    @merchant_repository = MerchantRepository.new("./data/merchants.csv")
  end
  it "exists" do
    expect(@merchant_repository).to be_a MerchantRepository
  end
  it "can return an array of all known merchants" do
    expect(@merchant_repository.all).to be_a Array
    expect(@merchant_repository.all.length).to eq(475)
    expect(@merchant_repository.all.first).to be_a Merchant
    expect(@merchant_repository.all.first.id).to eq("12334105")
    expect(@merchant_repository.all.first.name).to eq("Shopin1901")
  end
end
