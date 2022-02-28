require './lib/invoice_item'
require 'simplecov'
require 'bigdecimal'
# built in class method
SimpleCov.start

RSpec.describe InvoiceItem do
  before :each do
    @ii = InvoiceItem.new({
                    :id => 6,
                    :item_id => 7,
                    :invoice_id => 8,
                    :quantity => 1,
                    :unit_price => BigDecimal(10.99, 4),
                    :created_at => Time.now,
                    :updated_at => Time.now
                  })
  end
  describe 'InvoiceItem' do
    it 'exists' do
      expect(@ii).to be_a(InvoiceItem)
    end

    it 'has attributes' do
      expect(@ii.id).to eq(1)
      expect(@ii.item_id).to eq(7)
      expect(@ii.invoice_id).to eq(8)
      expect(@ii.quantity).to eq(1)
      expect(@ii.unit_price).to eq(0.1099e2)
      expect(@ii.created_at).to be_a(Time)
      expect(@ii.updated_at).to be_a(Time)
    end
  end

  describe 'Item methods' do
    it 'returns a unit_price to dollars' do
      expect(@ii.unit_price_to_dollars).to eq(10.99)
      expect(@ii.unit_price_to_dollars).to be_a(Float)
    end
  end
end
