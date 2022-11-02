# frozen_string_literal: true

require 'rspec'
require 'bigdecimal'
require './lib/invoice_item'

describe InvoiceItem do
  let(:time1) { Time.now }
  let(:time2) { Time.now }
  let(:ii) do
    InvoiceItem.new(
      {
        id: 6,
        item_id: 7,
        invoice_id: 8,
        quantity: 1,
        unit_price: BigDecimal(10.99, 4),
        created_at: time1,
        updated_at: time2
      }
    )
  end

  describe '#initialize' do
    it 'instantiates with appropriate attributes' do
      expect(ii).to be_a InvoiceItem
      expect(ii.id).to eq(6)
      expect(ii.item_id).to eq(7)
      expect(ii.invoice_id).to eq(8)
      expect(ii.quantity).to eq(1)
      expect(ii.unit_price).to eq(BigDecimal(10.99, 4))
      expect(ii.created_at).to eq(time1)
      expect(ii.updated_at).to eq(time2)
    end
  end
end
