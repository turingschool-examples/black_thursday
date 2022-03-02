# Invoice Items Test spec
require_relative '../lib/invoice_items'
require 'pry'

RSpec.describe 'Iteration 3' do
  context 'Invoices Items' do
    it 'exists' do
      i = InvoiceItem.new({
                            id: 1,
                            item_id: 263_519_844,
                            invoice_id: 1,
                            quantity: 5,
                            unit_price: 13_635,
                            created_at: Time.now,
                            updated_at: Time.now
                          })

      expect(i).to be_an(InvoiceItem)
    end

    it '#has attributes' do
      invoice_item = InvoiceItem.new({
                                       id: 2345,
                                       item_id: 263_562_118,
                                       invoice_id: 522,
                                       quantity: 5,
                                       unit_price: 84_787,
                                       created_at: '2012-03-27 14:54:35 UTC',
                                       updated_at: '2012-03-27 14:54:35 UTC'
                                     })

      expect(invoice_item.id).to eq(2345)
      expect(invoice_item.item_id).to eq(263_562_118)
      expect(invoice_item.invoice_id).to eq(522)
      expect(invoice_item.quantity).to eq(5)
      expect(invoice_item.unit_price).to eq(847.87)
      expect(invoice_item.created_at).to be_an_instance_of(Time)
      expect(invoice_item.updated_at).to be_an_instance_of(Time)
    end
  end
end
