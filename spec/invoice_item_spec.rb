require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'
require_relative '../lib/invoice'
require 'bigdecimal/util'

RSpec.describe InvoiceItem do

  describe '#initialize' do
    invoice_item = InvoiceItem.new({
                                                    :id => 6,
                                                    :item_id => 7,
                                                    :invoice_id => 8,
                                                    :quantity => 1,
                                                    :unit_price => ("1099"),
                                                    :created_at => Time.now,
                                                    :updated_at => Time.now
                                                  })

    it 'exists' do
      expect(invoice_item).to be_instance_of(InvoiceItem)
    end

    it 'has attributes available' do
      expect(invoice_item.id).to eq(6)
      expect(invoice_item.item_id).to eq(7)
      expect(invoice_item.invoice_id).to eq(8)
      expect(invoice_item.quantity).to eq(1)
      expect(invoice_item.unit_price).to eq(10.99)
      expect(invoice_item.created_at.class).to eq(Time)
      expect(invoice_item.updated_at.class).to eq(Time)
    end
  end
end
