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
                                      unit_price: '1300',
                                      created_at: '2012-03-27 14:54:09 UTC',
                                      updated_at: '2013-03-27 14:54:09 UTC'
                                     },
                                      mock_invoice_item_repository
                                    )
      expect(invoice_item.id).to eq(21854)
      expect(invoice_item.item_id).to eq(123654)
      expect(invoice_item.invoice_id).to eq(654123)
      expect(invoice_item.quantity).to eq(999)
      expect(invoice_item.unit_price).to eq(0.13e2)
      expect(invoice_item.created_at.year).to eq(2012)
      expect(invoice_item.updated_at.year).to eq(2013)
    end
  end
  describe '#unit_price_to_dollars' do
    it 'converts the unit price to dollars' do
      mock_invoice_item_repository = instance_double('InvoiceItemRepository')
      invoice_item = InvoiceItem.new({
                                      id: '21854 ',
                                      item_id: '123654',
                                      invoice_id: '654123',
                                      quantity: '999',
                                      unit_price: '1300',
                                      created_at: '2012-03-27 14:54:09 UTC',
                                      updated_at: '2013-03-27 14:54:09 UTC'
                                     },
                                      mock_invoice_item_repository
                                    )
      expect(invoice_item.unit_price_to_dollars).to eq(13.0)
    end
  end
  describe '#update' do
    it 'updates invoice item attributes' do
      mock_invoice_item_repository = instance_double('InvoiceItemRepository')
      invoice_item = InvoiceItem.new({
                                      id: '1 ',
                                      item_id: '263519844',
                                      invoice_id: '1',
                                      quantity: '5',
                                      unit_price: '1300',
                                      created_at: '2012-03-27 14:54:09 UTC',
                                      updated_at: '2013-03-27 14:54:09 UTC'
                                      },
                                      mock_invoice_item_repository
                                    )
      attributes = {
                    id: '1',
                    item_id: '263519844',
                    invoice_id: '1',
                    quantity: '6',
                    unit_price: '13000',
                    created_at: '2012-03-27 14:54:09 UTC',
                    updated_at: Time.now
                   }
      invoice_item.update(attributes)
      expected = invoice_item
      expect(expected.invoice_id).to eq(1)
      expect(expected.quantity).to eq(6)
      expect(expected.unit_price).to eq(13000)
      expect(expected.updated_at.year).to eq(2021)
    end
  end
end
