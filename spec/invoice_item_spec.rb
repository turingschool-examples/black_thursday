require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/invoice_item_repository'
require './lib/invoice_item'

RSpec.describe InvoiceItem do
  describe '#initialize' do
    it 'exists' do
      mock_invoice_item_repository = instance_double('InvoiceItemRepository')
      invoice_item = InvoiceItem.new({
            id: '21854 ',
            item_id: '123654',
            invoice_id: '654123',
            quantity: '999',
            unit_price: '987456',
            created_at: '2016-01-11 11:51:37 UTC',
            updated_at: '1993-09-29 11:56:40 UTC'
        },
        mock_invoice_item_repository
      )
      expect(invoice_item).to be_instance_of(InvoiceItem)
    end

    it 'has attributes' do
      mock_invoice_item_repository = instance_double('InvoiceItemRepository')
      invoice_item = InvoiceItem.new({
            id: '21854 ',
            item_id: '123654',
            invoice_id: '654123',
            quantity: '999',
            unit_price: '987456',
            created_at: '2012-03-27 14:54:09 UTC',
            updated_at: '2013-03-27 14:54:09 UTC'
        },
        mock_invoice_item_repository
      )
      expect(invoice_item.id).to eq(21854)
      expect(invoice_item.item_id).to eq(123654)
      expect(invoice_item.invoice_id).to eq(654123)
      expect(invoice_item.quantity).to eq(999)
      expect(invoice_item.unit_price).to eq(987456)
      expect(invoice_item.created_at.year).to eq(2012)
      expect(invoice_item.updated_at.year).to eq(2013)
    end
  end
end
