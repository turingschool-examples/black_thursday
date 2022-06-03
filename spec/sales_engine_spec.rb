require './lib/merchant_repository'
require './lib/merchant'
require './lib/item_repository'
require './lib/item'
require './lib/sales_engine'
require 'CSV'

RSpec.describe SalesEngine do
  before :each do
    @salesengine = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        })
  end

  it "exists" do
    expect(@salesengine).to be_a(SalesEngine)
  end

  it "can return an array of all items" do
    expect(@salesengine.item_repository).to be_instance_of ItemRepository
  end

  it "can return an array of all merchants" do
    expect(@salesengine.merchant_repository).to be_instance_of MerchantRepository
  end
end
