require "CSV"
require "rspec"
require "./data/items.csv"
require "./data/merchants.csv"
require "./lib/salesengine"
require "./lib/merchantrepository"
require "./lib/itemrepository"

RSpec.describe SalesEngine do
  describe 'instantiation' do
    it '::new' do
      se = SalesEngine.from_csv({:items => "./data/items.csv",
                                 :merchants => "./data/merchants.csv",})

      expect(se).to be_an_instance_of(SalesEngine)
    end
  end
end
