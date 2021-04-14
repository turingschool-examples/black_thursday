require 'rspec'
require './lib/sales_analyst'
require './lib/sales_engine'

RSpec.describe SalesAnalyst do
  describe '#average_items_per_merchant' do
    it 'averages the items per merchant' do

      sales_engine = SalesEngine.new

      mock_files = {
        items: './fake_items.csv',
        merchants: './fake_merchants.csv'
      }

      mock_item_row1_merch1 = {
        id: 12_345,
        name: 'Item 1',
        description: 'Item desc 1',
        unit_price: '12.23',
        merchant_id: '1'
      }
      mock_item_row2_merch1 = {
        id: 12_346,
        name: 'Item 2',
        description: 'Item desc 2',
        unit_price: '22.50',
        merchant_id: '1'
      }
      mock_item_row3_merch1 = {
        id: 12_347,
        name: 'Item 3',
        description: 'Item desc 3',
        unit_price: '50.25',
        merchant_id: '1'
      }

      mock_item_row1_merch2 = {
        id: 12_348,
        name: 'Item 1',
        description: 'Item desc 1',
        unit_price: '47.53',
        merchant_id: '2'
      }
      mock_item_row2_merch2 = {
        id: 12_349,
        name: 'Item 2',
        description: 'Item desc 2',
        unit_price: '12.72',
        merchant_id: '2'
      }
      mock_item_row3_merch2 = {
        id: 12_350,
        name: 'Item 3',
        description: 'Item desc 3',
        unit_price: '31.48',
        merchant_id: '2'
      }

      allow(CSV).to receive(:foreach).and_yield(mock_item_row1_merch1)
                                     .and_yield(mock_item_row2_merch1)
                                     .and_yield(mock_item_row3_merch1)
                                     .and_yield(mock_item_row1_merch2)
                                     .and_yield(mock_item_row2_merch2)
                                     .and_yield(mock_item_row3_merch2)

      sales_engine.load_items('./fake_items.csv')

      mock_merch1 = {
        id: 1,
        name: 'Dustin'
      }
      mock_merch2 = {
        id: 2,
        name: 'Sami'
      }

      allow(CSV).to receive(:foreach).and_yield(mock_merch1)
                                     .and_yield(mock_merch2)

      sales_engine.load_merchants('./fake_items.csv')

      sales_analyst = sales_engine.analyst

      expected_average = 3
      actual_average = sales_analyst.average_items_per_merchant
      expect(actual_average).to eq expected_average
    end
  end
end
