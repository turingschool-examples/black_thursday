require './lib/invoice_item'
require 'bigdecimal'

RSpec.describe 'InvoiceItem' do
  describe '#initialize' do
    before do
      @ii = InvoiceItem.new({
        :id          => 6,
        :item_id     => 7,
        :invoice_id  => 8,
        :quantity    => 1,
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now.round(1),
        :updated_at  => Time.now.round(1)
      })
    end

    it 'is an instance of InvoiceItem' do
      expect(@ii).to be_an_instance_of InvoiceItem
    end

    it 'has an id' do
      expect(@ii.id).to eq(6)
    end

    it 'has an item id' do
      expect(@ii.item_id).to eq(7)
    end

    it 'has an invoice id' do
      expect(@ii.invoice_id).to eq(8)
    end

    it 'has a quantity' do
      expect(@ii.quantity).to eq(1)
    end

    it 'has a unit price' do
      expect(@ii.unit_price).to eq(10.99)
    end

    it 'has a created at time' do
      expect(@ii.created_at).to eq(Time.now.round(1))
    end

    it 'has a updated at time' do
      expect(@ii.updated_at).to eq(Time.now.round(1))
    end

    it 'returns the price of invoice items' do
      expect(@ii.unit_price_to_dollars).to be_a(Float)
    end
  end
end
