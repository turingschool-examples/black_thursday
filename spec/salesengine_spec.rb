require "CSV"
require "RSpec"
require "./lib/salesengine"

RSpec.describe SalesEngine do
  describe 'instantiation' do
    it '::new' do

      se = SalesEngine.new({:items => "./data/items.csv",
                            :merchants => "./data/merchants.csv",})

      expect(se).to be_an_instance_of(SalesEngine)
    end

    it 'has csv' do
      se = SalesEngine.from_csv({:items => "./data/items.csv",
                                 :merchants => "./data/merchants.csv",})
      expect(se.from_csv).to eq([])
    end
  end
end
