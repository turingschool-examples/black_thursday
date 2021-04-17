require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_items'
require_relative '../lib/invoice'
require 'bigdecimal/util'

RSpec.describe InvoiceItems do

  describe '#initialize' do
    invoice_items = InvoiceItems.new({
                      :id          => 1,
                      :name        => "Pencil",
                      :description => "You can use it to write things",
                      :unit_price  => "1099",
                      :created_at  => Time.now,
                      :updated_at  => Time.now,
                      :merchant_id => 2
                    })

    it 'exists' do
      expect(invoice_items).to be_instance_of(InvoiceItems)
    end

    xit 'has attributes available' do
      # expect(item.id).to eq()
      expect(invoice_items.item_id).to eq(7)
      expect(invoice_items.invoice_id).to eq(8)
      expect(invoice_items.quantity).to eq(1)
      expect(invoice_items.unit_price).to eq("1099")
      expect(invoice_items.created_at.class).to eq(Time)
      expect(invoice_items.updated_at.class).to eq(Time)
    end
  end
end
