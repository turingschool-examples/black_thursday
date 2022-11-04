require './spec_helper'

RSpec.describe InvoiceItem do
  describe '#initialize' do
    it 'will exist and have attributes' do
      ii = InvoiceItem.new({
            :id => 6,
            :item_id => 7,
            :invoice_id => 8,
            :quantity => 1,
            :unit_price => BigDecimal(10.99, 4),
            :created_at => Time.now,
            :updated_at => Time.now
          })

      expect(ii).to be_a(InvoiceItem)
      expect(ii.id).to eq(6)
      expect(ii.item_id).to eq(7)
      expect(ii.invoice_id).to eq(8)
      expect(ii.quantity).to eq(1)
      expect(ii.unit_price).to eq(0.1099e2)    
    end
  end
end
