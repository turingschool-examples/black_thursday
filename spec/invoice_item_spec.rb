require_relative 'spec_helper'

RSpec.describe InvoiceItem do
  before :each do
    @mock_repo = double("InvoiceItemRepository")
    @ii_data = {
                  :id => 6,
                  :item_id => 7,
                  :invoice_id => 8,
                  :quantity => 1,
                  :unit_price => BigDecimal(10.99, 4),
                  :created_at => Time.now,
                  :updated_at => Time.now
                }

    @invoice_item = InvoiceItem.new(@ii_data, @mock_repo)
  end

  describe 'instantiation' do
    it 'exists' do
      expect(@invoice_item).to be_an(InvoiceItem)
    end

    it 'has attributes' do
      expect(@ii_data).to be_a(Hash)
      expect(@invoice_item.id).to eq(6)
      expect(@invoice_item.item_id).to eq(7)
      expect(@invoice_item.invoice_id).to eq(8)
      expect(@invoice_item.quantity).to eq(1)
      expect(@invoice_item.unit_price).to eq(0.1099e2)
      expect(@invoice_item.created_at).to be_a(Time)
      expect(@invoice_item.updated_at).to be_a(Time)
    end
  end
end
