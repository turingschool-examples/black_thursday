require 'bigdecimal'
require 'invoice_item_repo'
require 'invoice_item'

RSpec.describe InvoiceItem do
  describe 'instantiation' do
    it '::new' do
      mock_repo = double('InvoiceItemRepo')
      invoice_items = InvoiceItem.new({:id         => 6,
                                      :item_id     => 7,
                                      :invoice_id  => 8,
                                      :quantity    => 1,
                                      :unit_price  => BigDecimal(10.99,4),
                                      :created_at  => Time.now,
                                      :updated_at  => Time.now,
                                      }, mock_repo)

      expect(invoice_items).to be_an_instance_of(InvoiceItem)
    end

    it 'has attributes' do
      mock_repo = double('InvoiceItemRepo')
      invoice_items = InvoiceItem.new({:id          => 6,
                                       :item_id     => 7,
                                       :invoice_id  => 8,
                                       :quantity    => 1,
                                       :unit_price  => BigDecimal(10.99,4),
                                       :created_at  => Time.now,
                                       :updated_at  => Time.now,
                                       }, mock_repo)
      expect(invoice_items.id).to eq(6)
      expect(invoice_items.item_id).to eq(7)
      expect(invoice_items.invoice_id).to eq(8)
      expect(invoice_items.quantity).to eq(1)
      expect(invoice_items.unit_price).to be_an_instance_of(BigDecimal)
      expect(invoice_items.created_at).to be_an_instance_of(Time)
      expect(invoice_items.updated_at).to be_an_instance_of(Time)
    end
  end

  describe '#methods' do
    it '#unit price to dollars' do
      mock_repo = double('InvoiceItemRepo')
      invoice_items = InvoiceItem.new({:id          => 6,
                                       :item_id     => 7,
                                       :invoice_id  => 8,
                                       :quantity    => 1,
                                       :unit_price  => 1099,
                                       :created_at  => Time.now,
                                       :updated_at  => Time.now,
                                       }, mock_repo)

      expect(invoice_items.unit_price_to_dollars).to eq(10.99)
    end
  end
end
