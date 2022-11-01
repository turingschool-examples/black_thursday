require './lib/salesengine'
require './lib/merchantrepository'
# require './lib/itemrepository'
require './lib/merchant'
require 'csv'

RSpec.describe SalesEngine do
  # let(:se) {SalesEngine.from_csv({
  #                                 :merchants => './data/merchants.csv'})}

  before(:each) do 
    @se = SalesEngine.from_csv({:merchants => './data/merchants.csv'})
  end

  it 'is an instance of a sales engine' do
    expect(@se).to be_a(SalesEngine)
  end

  it 'has a method to access the merchant repository with all the merchants loaded' do
    
    expect(@se.merchants).to be_a(Merchant_Repository)
    expect(@se.merchants.find_by_name("Bowlsbychris")).to be_a(Merchant)
  end

end
# :items => './data/items.csv',