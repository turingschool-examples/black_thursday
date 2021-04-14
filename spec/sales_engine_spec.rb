require 'rspec'
require 'CSV'
require './lib/sales_engine'
require './lib/sales_analyst'

describe SalesEngine do
  describe '#from_csv' do
    it 'creates a new instance of SalesEngine' do
      allow_any_instance_of(SalesEngine).to receive(:load_items)
      allow_any_instance_of(SalesEngine).to receive(:load_merchants)

      sales_engine = SalesEngine.from_csv(items: './file1.csv', merchants: './file2.csv')
      expect(sales_engine).to be_instance_of SalesEngine
    end

    it 'calls load_items and load_merchants' do
      items_file_name = './file1.csv'
      merchants_file_name = './file2.csv'

      allow_any_instance_of(SalesEngine).to receive(:load_items)
      allow_any_instance_of(SalesEngine).to receive(:load_merchants)

      sales_engine = SalesEngine.from_csv(items: items_file_name, merchants: merchants_file_name)

      expect(sales_engine).to have_received(:load_items).with items_file_name
      expect(sales_engine).to have_received(:load_merchants).with merchants_file_name
    end
  end

  describe '#load_items' do
    it 'loads items and populates items array' do
      mock_row = {
        id: 12_345,
        name: 'Smith',
        description: 'Item desc',
        unit_price: '12.23',
        merchant_id: '12345'
      }

      allow(CSV).to receive(:foreach).and_yield(mock_row)

      mock_file_name = './some_file.csv'

      sales_engine = SalesEngine.new
      sales_engine.load_items(mock_file_name)

      actual_merchants = sales_engine.items.all

      expect(actual_merchants).to be_instance_of Array
      expect(actual_merchants.first.id).to eq 12_345
      expect(actual_merchants.first.name).to eq 'Smith'
    end
  end

  describe '#load_merchants' do
    it 'loads merchants and populates merchants array' do
      mock_row = { id: 12_345, name: 'Smith' }

      allow(CSV).to receive(:foreach).and_yield(mock_row)

      mock_file_name = './some_file.csv'

      sales_engine = SalesEngine.new
      sales_engine.load_merchants(mock_file_name)

      actual_merchants = sales_engine.merchants.all

      expect(actual_merchants).to be_instance_of Array
      expect(actual_merchants.first.id).to eq 12_345
      expect(actual_merchants.first.name).to eq 'Smith'
    end
  end

  describe '#analyst' do
    it 'returns a new instance of SalesAnalyst' do
      sales_engine = SalesEngine.new
      sales_analyst = sales_engine.analyst
      expect(sales_analyst).to be_instance_of SalesAnalyst
    end
  end
end
