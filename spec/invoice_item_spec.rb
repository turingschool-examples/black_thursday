require 'RSpec'
require 'CSV'
require 'bigdecimal'
require 'invoice_item_repository'
require 'invoice_item'

RSpec.describe InvoiceItem do
  describe 'instantiation' do
    it '::new' do
      invoice_items = InvoiceItem.new({:id         => 6,
                                      :item_id     => 7,
                                      :invoice_id  => 8,
                                      :quantity    => 1,
                                      :unit_price  => BigDecimal(10.99,4),
                                      :created_at  => Time.now,
                                      :updated_at  => Time.now,
                                      }, @repo)

      expect(invoice_items).to be_an_instance_of(InvoiceItem)
    end

    it 'has attributes' do
      invoice_items = InvoiceItem.new({:id          => 6,
                                       :item_id     => 7,
                                       :invoice_id  => 8,
                                       :quantity    => 1,
                                       :unit_price  => BigDecimal(10.99,4),
                                       :created_at  => Time.now,
                                       :updated_at  => Time.now,
                                       }, @repo)
      expect(invoice_items.id).to eq(6)
      expect(invoice_items.item_id).to eq(7)
      expect(invoice_items.invoice_id).to eq(8)
      expect(invoice_items.quantity).to eq(1)
    end
  end


end
