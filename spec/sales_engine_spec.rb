require 'rspec'
require './lib/sales_engine'

describe SalesEngine do
  describe '#from_csv' do
    it 'creates a new instance of SalesEngine' do
      sales_engine = SalesEngine.from_csv(items: './data/items.csv', 
                                          merchants: './data/merchants.csv')
      expect(sales_engine).to be_instance_of SalesEngine
    end
  end
end
