# Invoice Items Test spec
require_relative '../lib/invoice_items'
require 'pry'

RSpec.describe 'Iteration 3' do
  context 'Invoices Items' do
    it 'exists' do
      i = InvoiceItem.new({
                        id: 1,
                        item_id: 263519844,
                        invoice_id: 1,
                        quantity: 5,
                        unit_price: 13635,
                        created_at: Time.now,
                        updated_at: Time.now
                      })

      expect(i).to be_an(InvoiceItem)
    end

    it '#has attributes' do
      i = InvoiceItem.new({
                        id: 1,
                        item_id: 263519844,
                        invoice_id: 1,
                        quantity: 5,
                        unit_price: 13635,
                        created_at: '2012-03-27 14:54:09 UTC',
                        updated_at: '2012-03-27 14:54:09 UTC'
                      })

      expect(i.id).to eq(1)
      expect(i.item_id).to eq(263519844)
      expect(i.invoice_id).to eq(1)
      expect(i.quantity).to eq(5)
      # expect(i.unit_price).to eq(136.35)
      expect(i.created_at).to be_an_instance_of(Time)
      expect(i.updated_at).to be_an_instance_of(Time)
    end
  end
end
