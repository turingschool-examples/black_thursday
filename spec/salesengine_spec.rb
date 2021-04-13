require "CSV"
require "RSpec"
require "./lib/salesengine"
require "./lib/item"

RSpec.describe SalesEngine do
  describe 'instantiation' do
    it '::new' do

      se = SalesEngine.new({:items => "./data/items.csv",
                            :merchants => "./data/merchants.csv",})

      expect(se).to be_an_instance_of(SalesEngine)
    end

    it 'has attributes' do
      se = SalesEngine.new({:items => "./data/items.csv",
                                 :merchants => "./data/merchants.csv",})

      expect(se.item).to eq('./data/items.csv')
      expect(se.merchant).to eq('./data/merchants.csv')
    end
  end

  describe 'method' do
    it '#from_csv' do
      se = SalesEngine.new({:items => "./data/items.csv",
                            :merchants => "./data/merchants.csv",})
      se = SalesEngine.from_csv({:items => "./data/items.csv",
                                 :merchants => "./data/merchants.csv",})

      # expect(thepart.confusion)
    end
  end
end
