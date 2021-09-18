require 'rspec'
require 'csv'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchants_repository'
require './lib/items'
require './lib/item_repository'
require './lib/sales_analyst'

describe SalesAnalyst do

  describe '#initialize' do
    it 'creates an instance of SalesAnalyst' do
      se = SalesEngine.new({
        :items => './data/items.csv',
        :merchants => './data/merchants.csv'
        })
      sales_analyst = se.analyst(se.items, se.merchants)

      expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
    end
  end

end
