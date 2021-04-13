require 'rspec'
require 'CSV'
require './lib/sales_engine'

describe SalesEngine do
  describe '#from_csv' do

    it 'creates a new instance of SalesEngine' do
      sales_engine = SalesEngine.from_csv(items: './data/items.csv', merchants: './data/merchants.csv')
      expect(sales_engine).to be_instance_of SalesEngine
    end

    it 'initialize calls load_items and load_merchants' do
      items_file_name = './data/items.csv'
      merchants_file_name = './data/merchants.csv'

      allow_any_instance_of(SalesEngine).to receive(:load_items)
      allow_any_instance_of(SalesEngine).to receive(:load_merchants)

      sales_engine = SalesEngine.from_csv(items: items_file_name, merchants: merchants_file_name)

      expect(sales_engine).to have_received(:load_items).with items_file_name
      expect(sales_engine).to have_received(:load_merchants).with merchants_file_name
    end
  end

  describe '#load_items' do
    it 'loads items and populates items array' do
      mock_row = instance_double('Row', id: '12345', name: 'Some Name')
      allow(CSV).to receive(:foreach).and_yield(mock_row)
      mock_file_name = './some_file.csv'

      sales_engine = SalesEngine.new
      sales_engine.load_items(mock_file_name)

      actual_merchants = sales_engine.items

      expect(actual_merchants).to be_instance_of Array
      expect(actual_merchants.first.id).to eq '12345'
      expect(actual_merchants.first.name).to eq 'Smith'
    end
  end

  describe '#load_merchants' do
    it 'loads merchants and populates merchants array' do
      mock_row = instance_double('Row', id: '12345', name: 'Smith')
      allow(CSV).to receive(:foreach).and_yield(mock_row)

      mock_file_name = './some_file.csv'

      sales_engine = SalesEngine.new
      sales_engine.load_merchants(mock_file_name)

      actual_merchants = sales_engine.merchants

      expect(actual_merchants).to be_instance_of Array
      expect(actual_merchants.first.id).to eq '12345'
      expect(actual_merchants.first.name).to eq 'Smith'
    end
  end
end
