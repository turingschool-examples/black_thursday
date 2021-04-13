require 'rspec'
require './lib/sales_engine'

describe SalesEngine do
  describe '#from_csv' do
    it 'creates a new instance of SalesEngine with no files' do
      sales_engine = SalesEngine.from_csv(items: '', merchants: '')
      expect(sales_engine).to be_instance_of SalesEngine
    end
  end
end
