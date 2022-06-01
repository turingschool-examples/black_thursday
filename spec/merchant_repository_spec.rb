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
end
