require 'rspec'
require './lib/sales_engine'

describe SalesEngine do
  describe '#from_csv' do

    it 'creates a new instance of SalesEngine' do
      sales_engine = SalesEngine.from_csv(items: './data/items.csv',
                                          merchants: './data/merchants.csv')
      expect(sales_engine).to be_instance_of SalesEngine
    end

    it 'initialize calls load_items and load_merchants' do
      items_file_name = './data/items.csv'
      merchants_file_name = './data/merchants.csv'

      allow_any_instance_of(SalesEngine).to receive(:load_items)
      allow_any_instance_of(SalesEngine).to receive(:load_merchants)

      sales_engine = SalesEngine.from_csv(items: items_file_name,
                                          merchants: merchants_file_name)

      expect(sales_engine).to have_received(:load_items).with items_file_name
      expect(sales_engine).to have_received(:load_merchants).with merchants_file_name
    end
  end

end
