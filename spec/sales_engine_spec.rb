require './lib/merchant_repository'
require './lib/merchant'
require './lib/item_repository'
require './lib/item'
require './lib/sales_engine'

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
end 
