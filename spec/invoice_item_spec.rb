# frozen_string_literal: true

require 'rspec'
require 'bigdecimal'
require 'time'
require './lib/invoice_item'

describe InvoiceItem do
  let(:time1) { Time.parse("2020-12-20 20:20:20") }
  let(:time2) { Time.parse("2020-12-20 20:20:20") }
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

  describe '#unit_price_to_dollars' do
    it 'returns item unit price converted to dollars' do
      expect(ii.unit_price_to_dollars).to eq(10.99)
    end
  end

  describe '#update' do
    it 'changes the quantity and unit_price and sets updated_at to current time' do
      ii.update(
        {
          quantity: 2,
          unit_price: BigDecimal(11.69, 4)
        }
      )
      expect(ii.quantity).to eq(2)
      expect(ii.unit_price).to eq(BigDecimal(11.69, 4))
      expect(ii.updated_at).not_to eq(time2)
    end
  end
end
