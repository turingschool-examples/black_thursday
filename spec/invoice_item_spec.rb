require_relative '../lib/invoice_item'
require 'bigdecimal'

RSpec.describe InvoiceItem do 
  let(:invoice_item) { InvoiceItem.new(
                      :id => 6,
                      :item_id => 7,
                      :invoice_id => 8,
                      :quantity => 1,
                      :unit_price => BigDecimal("1099",4),
                      :created_at => Time.now,
                      :updated_at => Time.now
                    )}

  describe '#initialize' do
    it 'exists' do
      expect(invoice_item).to be_a(InvoiceItem)
    end
  end 
end