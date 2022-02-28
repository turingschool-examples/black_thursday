require 'csv'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item'
require_relative 'spec_helper'

#headers
#id,item_id,invoice_id,quantity,unit_price,created_at,updated_at
RSpec.describe InvoiceItem do
  before (:each) do
    @invoice_item = InvoiceItem.new({id: 1,
      item_id: 263519844,
      invoice_id: 1,
      quantity: 5,
      unit_price: 13635,
      created_at: "2012-03-27 14:54:09 UTC",
      updated_at: "2012-03-27 14:54:09 UTC" })
    end

    context 'InvoceItem' do
      it 'can read Item attributes' do
        expect(@invoice_item.id).to eq(1)
        expect(@invoice_item.item_id).to eq(263519844)
        expect(@invoice_item.invoice_id).to eq(1)
        expect(@invoice_item.quantity).to eq(5)
        expect(@invoice_item.unit_price).to eq(136.35)
        expect(@invoice_item.created_at).to eq(Time.parse("2012-03-27 14:54:09 UTC"))
        expect(@invoice_item.updated_at).to eq(Time.parse("2012-03-27 14:54:09 UTC"))
      end

      it '#unit_price_to_dollars can return price of items in dollars as float' do
        expect(@invoice_item.unit_price_to_dollars).to eq(136.35)
      end
    end
end
