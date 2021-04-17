require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/invoice_repository'
require './lib/invoice'
require './lib/item'
require './lib/invoice_item_repository'
require 'bigdecimal'

RSpec.describe InvoiceItemRepository do
  describe '#initialize' do
    it 'exists' do
      mock_sales_engine = instance_double('SalesEngine')
      iir = InvoiceItemRepository.new('./spec/truncated_data/invoice_items_truncated.csv', mock_sales_engine)
      expect(iir).to be_instance_of(InvoiceItemRepository)
    end
  end
end
