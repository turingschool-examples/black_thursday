require 'rspec'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchants_repository'
require './lib/items'
require './lib/item_repository'
require 'csv'

describe SalesEngine do

  describe '#initialize' do
    it 'creates an instance of SalesEngine' do
      se = SalesEngine.new({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv"
        })
      expect(se).to be_an_instance_of SalesEngine
    end
  end

  describe '#items' do
    it 'returns a new instance of ItemRepository with an array of item objects' do
      se = SalesEngine.new({
        :items     => "test.csv",
        :merchants => "test_2.csv"
        })
      ir = se.items

      expect(ir).to be_an_instance_of(ItemRepository)
      expect(it.all).to eq(['insert expected results here'])
    end
  end

end
