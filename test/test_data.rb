require './lib/customer_repository'
require './lib/customer'
require './lib/invoice_repository'
require './lib/invoice'
require './lib/invoice_item_repository'
require './lib/invoice_item'
require './lib/item_repository'
require './lib/item'
require './lib/merchant_repository'
require './lib/merchant'
require 'bigdecimal'

module TestData
  def make_some_test_data
    @now = Time.now

    @mr = MerchantRepository.new
    @cr = CustomerRepository.new
    @ir = InvoiceRepository.new
    @iir = InvoiceItemRepository.new
    @itemr = ItemRepository.new

    @m_1 = Merchant.new({id: 10, name: "Bettys Beans"})
    @m_1 = Merchant.new({id: 11, name: "Freds Fireworks"})

    @c_1 = Customer.new({
      :id => 1,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => @now,
      :updated_at => @now
    })

    @c_2 = Customer.new({
      :id => 2,
      :first_name => "Jeff",
      :last_name => "Baconson",
      :created_at => @now,
      :updated_at => @now
    })

    @cr.instances << @c_1
    @cr.instances << @c_2

    @inv_1 = Invoice.new({
      :id          => 4,
      :customer_id => 1,
      :merchant_id => 10,
      :status      => "pending",
      :created_at  => @now,
      :updated_at  => @now,
    })

    @inv_2 = Invoice.new({
      :id          => 5,
      :customer_id => 2,
      :merchant_id => 11,
      :status      => "pending",
      :created_at  => @now,
      :updated_at  => @now,
    })

    @ir.instances << @inv_1
    @ir.instances << @inv_2

    @ii_1 = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 4,
      :quantity => 1,
      :unit_price => BigDecimal.new(15.99, 4),
      :created_at => @now,
      :updated_at => @now
    })

    @ii_2 = InvoiceItem.new({
      :id => 7,
      :item_id => 8,
      :invoice_id => 5,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => @now,
      :updated_at => @now
    })

    @iir.instances << @ii_1
    @iir.instances << @ii_2

    @i_1 = Item.new({
      :id          => 7,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => @now,
      :updated_at  => @now,
      :merchant_id => 10
    })

    @i_2 = Item.new({
      :id          => 8,
      :name        => "Bag",
      :description => "You can use it to store things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => @now,
      :updated_at  => @now,
      :merchant_id => 11
    })

    @itemr.instances << @i_1
    @itemr.instances << @i_2
  end
end
