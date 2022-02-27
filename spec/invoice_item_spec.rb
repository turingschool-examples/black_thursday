require 'rspec'
require './lib/invoice_item'

describe InvoiceItem do
  describe 'initialize' do
    ii = InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    })

    it 'has readable attributes' do
      expect(ii.id).to eq(6)
      expect(ii.item_id).to eq(7)
      expect(ii.invoice_id).to eq(8)
      expect(ii.quantity).to eq(1)
      expect(ii.unit_price.to_f).to eq(10.99)
      expect(ii.created_at).to be_a(Time)
      expect(ii.updated_at).to be_a(Time)
    end
  end

  describe 'unit_price_to_dollars' do
    ii = InvoiceItem.new({
    :id => 6,
    :item_id => 7,
    :invoice_id => 8,
    :quantity => 1,
    :unit_price => BigDecimal(10.99, 4),
    :created_at => Time.now,
    :updated_at => Time.now
    })

    it 'converts the unit price to a float' do
      expect(ii.unit_price_to_dollars).to eq(10.99)
    end
  end
end
