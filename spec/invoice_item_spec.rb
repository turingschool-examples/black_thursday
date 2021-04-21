require 'bigdecimal'
require 'invoice_item_repo'
require 'invoice_item'

RSpec.describe InvoiceItem do
  describe 'instantiation' do
    it '::new' do
      mock_repo = double('InvoiceItemRepo')
      invoice_item = InvoiceItem.new({:id         => 6,
                                      :item_id     => 7,
                                      :invoice_id  => 8,
                                      :quantity    => 1,
                                      :unit_price  => BigDecimal(10.99,4),
                                      :created_at  => Time.now,
                                      :updated_at  => Time.now,
                                      }, mock_repo)

      expect(invoice_item).to be_an_instance_of(InvoiceItem)
    end

    it 'has attributes' do
      mock_repo = double('InvoiceItemRepo')
      invoice_item = InvoiceItem.new({:id          => 6,
                                       :item_id     => 7,
                                       :invoice_id  => 8,
                                       :quantity    => 1,
                                       :unit_price  => BigDecimal(10.99,4),
                                       :created_at  => Time.now,
                                       :updated_at  => Time.now,
                                       }, mock_repo)
      expect(invoice_item.id).to eq(6)
      expect(invoice_item.item_id).to eq(7)
      expect(invoice_item.invoice_id).to eq(8)
      expect(invoice_item.quantity).to eq(1)
      expect(invoice_item.unit_price).to be_an_instance_of(BigDecimal)
      expect(invoice_item.created_at).to be_an_instance_of(Time)
      expect(invoice_item.updated_at).to be_an_instance_of(Time)
    end
  end

  describe '#methods' do
    it '#unit price to dollars' do
      mock_repo = double('InvoiceItemRepo')
      invoice_item = InvoiceItem.new({:id          => 6,
                                      :item_id     => 7,
                                      :invoice_id  => 8,
                                      :quantity    => 1,
                                      :unit_price  => 1099,
                                      :created_at  => Time.now,
                                      :updated_at  => Time.now,}, mock_repo)

      expect(invoice_item.unit_price_to_dollars).to eq(10.99)
    end

    it '#update quantity' do
      mock_repo = double('InvoiceItemRepo')
      invoice_item = InvoiceItem.new({:id          => 6,
                                      :item_id     => 7,
                                      :invoice_id  => 8,
                                      :quantity    => 1,
                                      :unit_price  => 1099,
                                      :created_at  => Time.now,
                                      :updated_at  => Time.now,}, mock_repo)

      invoice_item.update_quantity({:quantity => 10})

      expect(invoice_item.quantity).to eq(10)

      invoice_item.update_quantity({:item_id => 1 })

      expect(invoice_item.quantity).to eq(10)
    end

    it '#update unit price' do
      mock_repo = double('InvoiceItemRepo')
      invoice_item = InvoiceItem.new({:id          => 6,
                                      :item_id     => 7,
                                      :invoice_id  => 8,
                                      :quantity    => 1,
                                      :unit_price  => 1099,
                                      :created_at  => Time.now,
                                      :updated_at  => Time.now,}, mock_repo)

      invoice_item.update_unit_price(:unit_price => BigDecimal(15.99,4))
      
      expect(invoice_item.unit_price).to eq(15.99)

      invoice_item.update_unit_price(:id => 2)

      expect(invoice_item.unit_price).to eq(15.99)
    end

    it '#update updated at' do
      mock_repo = double("InvoiceRepo")
      invoice_item = InvoiceItem.new({:id          => 6,
                                      :item_id     => 7,
                                      :invoice_id  => 8,
                                      :quantity    => 1,
                                      :unit_price  => 1099,
                                      :created_at  => Time.now,
                                      :updated_at  => Time.now,}, mock_repo)
  
      invoice_item.update_updated_at({:updated_at => Time.now})
  
      expect(invoice_item.updated_at).to be_an_instance_of(Time)
    end

    it '#update id' do
      mock_repo = double('ItemRepo')
      invoice_item = InvoiceItem.new({:id          => 6,
                                      :item_id     => 7,
                                      :invoice_id  => 8,
                                      :quantity    => 1,
                                      :unit_price  => 1099,
                                      :created_at  => Time.now,
                                      :updated_at  => Time.now,}, mock_repo)

      new_id = 10000

      expect(invoice_item.update_id(10000)).to eq 10001
    end
  end
end
