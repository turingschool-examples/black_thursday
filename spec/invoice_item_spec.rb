require_relative '../lib/invoice_item'
require 'bigdecimal'

RSpec.describe InvoiceItem do 
  let(:invoice_item) { InvoiceItem.new({
                      :id => 6,
                      :item_id => 7,
                      :invoice_id => 8,
                      :quantity => 1,
                      :unit_price => BigDecimal("1099",4),
                      :created_at => Time.now,
                      :updated_at => Time.now
                    })}

  describe '#initialize' do
    it 'exists' do
      expect(invoice_item).to be_a(InvoiceItem)
    end
  end

  describe 'attributes' do 
    it '#id' do 
      expect(invoice_item.id).to eq(6)
    end

    it '#item_id' do 
      expect(invoice_item.item_id).to eq(7)
    end

    it '#invoice_id' do 
      expect(invoice_item.invoice_id).to eq(8)
    end

    it '#quantity' do 
      expect(invoice_item.quantity).to eq(1)
    end

    it '#unit_price' do 
      expect(invoice_item.unit_price).to eq(10.99)
    end

    it '#created_at' do 
      expect(invoice_item.created_at).to be_a(Time)
    end

    it '#updated_at' do
      expect(invoice_item.updated_at).to be_a(Time)
    end
  end

  describe '#unit_price_to_dollars' do
    it 'returns the price of the invoice item in dollars as a Float' do 
      expect(invoice_item.unit_price_to_dollars).to eq("$10.99")
    end
  end
end