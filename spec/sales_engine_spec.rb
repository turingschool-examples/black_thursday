require './lib/sales_engine'
require './lib/merchant_repository'
# require './lib/item_repository'
require './lib/merchant'
require 'csv'

RSpec.describe SalesEngine do
  let(:se) {SalesEngine.from_csv({:items => './data/items.csv',
                                  :merchants => './data/merchants.csv'})}

  # before(:each) do 
  #   @se = SalesEngine.from_csv({:merchants => './data/merchants.csv'})
  

  it 'is an instance of a sales engine' do
    expect(se).to be_a(SalesEngine)
  end

  it 'has a method to access the merchant repository with all the merchants loaded' do
    expect(se.merchants).to be_a(MerchantRepository)
    expect(se.merchants.find_by_name("Bowlsbychris")).to be_a(Merchant)
  end

  it 'has a method to access the item repository with all items loaded' do
    expect(se.items).to be_a(ItemRepository)
    expect(se.items.find_by_name("Silver Plated Clutch with Swarovski Element Crystals")).to be_a(Item)
  end
end
# :items => './data/items.csv',