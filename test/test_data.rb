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
require './lib/transaction_repository'
require 'bigdecimal'

module TestData
  def make_top_buyers_test_data
    @now = Time.now
    @customer_1 = Customer.new({
      :id => 1,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => @now,
      :updated_at => @now
    })

    @customer_2 = Customer.new({
      :id => 2,
      :first_name => "Bob",
      :last_name => "Ross",
      :created_at => @now,
      :updated_at => @now
    })

    @customer_3 = Customer.new({
      :id => 3,
      :first_name => "Duck",
      :last_name => "Smith",
      :created_at => @now,
      :updated_at => @now
    })

    @customers.instances << @customer_1
    @customers.instances << @customer_2
    @customers.instances << @customer_3

    @inv_1 = Invoice.new({
      :id          => 1,
      :customer_id => 1,
      :merchant_id => 10,
      :status      => "pending",
      :created_at  => @now,
      :updated_at  => @now,
    })

    @inv_2 = Invoice.new({
      :id          => 2,
      :customer_id => 2,
      :merchant_id => 11,
      :status      => "pending",
      :created_at  => @now,
      :updated_at  => @now,
    })

    @inv_3 = Invoice.new({
      :id          => 3,
      :customer_id => 3,
      :merchant_id => 12,
      :status      => "pending",
      :created_at  => @now,
      :updated_at  => @now,
    })

    @invoices.instances << @inv_1
    @invoices.instances << @inv_2
    @invoices.instances << @inv_3

    @t_1 = Transaction.new({
      :id => 1,
      :invoice_id => 1,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => :success,
      :created_at => @now,
      :updated_at => @now
    })

    @t_2 = Transaction.new({
      :id => 2,
      :invoice_id => 2,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => :success,
      :created_at => @now,
      :updated_at => @now
    })

    @t_3 = Transaction.new({
      :id => 3,
      :invoice_id => 3,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => :success,
      :created_at => @now,
      :updated_at => @now
    })

    @transactions.instances << @t_1
    @transactions.instances << @t_2
    @transactions.instances << @t_3

    @ii_1 = InvoiceItem.new({
      :id => 1,
      :item_id => 7,
      :invoice_id => 1,
      :quantity => 1,
      :unit_price => BigDecimal.new(15.99, 4),
      :created_at => @now,
      :updated_at => @now
    })

    @ii_2 = InvoiceItem.new({
      :id => 2,
      :item_id => 8,
      :invoice_id => 2,
      :quantity => 2,
      :unit_price => BigDecimal.new(15.99, 4),
      :created_at => @now,
      :updated_at => @now
    })

    @ii_3 = InvoiceItem.new({
      :id => 3,
      :item_id => 9,
      :invoice_id => 3,
      :quantity => 3,
      :unit_price => BigDecimal.new(15.99, 4),
      :created_at => @now,
      :updated_at => @now
    })

    @invoice_items.instances << @ii_1
    @invoice_items.instances << @ii_2
    @invoice_items.instances << @ii_3
  end

  def make_one_time_buyers_test_data
    @customer_1 = Customer.new({
      :id => 1,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => @now,
      :updated_at => @now
    })

    @customer_2 = Customer.new({
      :id => 2,
      :first_name => "Bob",
      :last_name => "Ross",
      :created_at => @now,
      :updated_at => @now
    })

    @customers.instances << @customer_1
    @customers.instances << @customer_2

    @inv_1 = Invoice.new({
      :id          => 1,
      :customer_id => 1,
      :merchant_id => 10,
      :status      => "pending",
      :created_at  => @now,
      :updated_at  => @now,
    })

    @inv_2 = Invoice.new({
      :id          => 2,
      :customer_id => 2,
      :merchant_id => 11,
      :status      => "pending",
      :created_at  => @now,
      :updated_at  => @now,
    })

    @inv_3 = Invoice.new({
      :id          => 3,
      :customer_id => 2,
      :merchant_id => 12,
      :status      => "pending",
      :created_at  => @now,
      :updated_at  => @now,
    })

    @invoices.instances << @inv_1
    @invoices.instances << @inv_2
    @invoices.instances << @inv_3
  end

  def make_one_time_buyers_top_item_test_data
    @customer_1 = Customer.new({
      :id => 1,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => @now,
      :updated_at => @now
    })

    @customer_2 = Customer.new({
      :id => 2,
      :first_name => "Bob",
      :last_name => "Ross",
      :created_at => @now,
      :updated_at => @now
    })

    @customers.instances << @customer_1
    @customers.instances << @customer_2

    @inv_1 = Invoice.new({
      :id          => 1,
      :customer_id => 1,
      :merchant_id => 10,
      :status      => "pending",
      :created_at  => @now,
      :updated_at  => @now,
    })

    @inv_2 = Invoice.new({
      :id          => 2,
      :customer_id => 2,
      :merchant_id => 11,
      :status      => "pending",
      :created_at  => @now,
      :updated_at  => @now,
    })

    @invoices.instances << @inv_1
    @invoices.instances << @inv_2

    @ii_1 = InvoiceItem.new({
      :id => 1,
      :item_id => 2,
      :invoice_id => 1,
      :quantity => 4,
      :unit_price => BigDecimal.new(15.99, 4),
      :created_at => @now,
      :updated_at => @now
    })

    @ii_2 = InvoiceItem.new({
      :id => 1,
      :item_id => 3,
      :invoice_id => 2,
      :quantity => 2,
      :unit_price => BigDecimal.new(15.99, 4),
      :created_at => @now,
      :updated_at => @now
    })

    @invoice_items.instances << @ii_1
    @invoice_items.instances << @ii_2

    @t_1 = Transaction.new({
      :id => 1,
      :invoice_id => 1,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => :success,
      :created_at => @now,
      :updated_at => @now
    })

    @t_2 = Transaction.new({
      :id => 2,
      :invoice_id => 1,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => :success,
      :created_at => @now,
      :updated_at => @now
    })

    @t_3 = Transaction.new({
      :id => 3,
      :invoice_id => 2,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => :success,
      :created_at => @now,
      :updated_at => @now
    })

    @transactions.instances << @t_1
    @transactions.instances << @t_2
    @transactions.instances << @t_3

    @item_1 = Item.new({
      :id          => 2,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => @now,
      :updated_at  => @now,
      :merchant_id => 2
    })

    @items.instances << @item_1
  end

  def make_top_merchant_and_invoice_items_test_data
    @customer_1 = Customer.new({
      :id => 1,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => @now,
      :updated_at => @now
    })

    @customers.instances << @customer_1

    @m = Merchant.new({:id => 5, :name => "Turing School"})
    @m_2 = Merchant.new({:id => 6, :name => "Code School"})

    @merchants.instances << @m
    @merchants.instances << @m_2

    @inv_1 = Invoice.new({
      :id          => 1,
      :customer_id => 1,
      :merchant_id => 5,
      :status      => "pending",
      :created_at  => @now,
      :updated_at  => @now,
    })

    @inv_2 = Invoice.new({
      :id          => 2,
      :customer_id => 1,
      :merchant_id => 6,
      :status      => "pending",
      :created_at  => @now,
      :updated_at  => @now,
    })

    @inv_3 = Invoice.new({
      :id          => 3,
      :customer_id => 1,
      :merchant_id => 6,
      :status      => "pending",
      :created_at  => @now,
      :updated_at  => @now,
    })

    @invoices.instances << @inv_1
    @invoices.instances << @inv_2
    @invoices.instances << @inv_3

    @ii_1 = InvoiceItem.new({
      :id => 1,
      :item_id => 3,
      :invoice_id => 1,
      :quantity => 6,
      :unit_price => BigDecimal.new(15.99, 4),
      :created_at => @now,
      :updated_at => @now
    })

    @ii_2 = InvoiceItem.new({
      :id => 1,
      :item_id => 3,
      :invoice_id => 2,
      :quantity => 2,
      :unit_price => BigDecimal.new(15.99, 4),
      :created_at => @now,
      :updated_at => @now
    })

    @invoice_items.instances << @ii_1
    @invoice_items.instances << @ii_2

    @t_1 = Transaction.new({
      :id => 1,
      :invoice_id => 1,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => :success,
      :created_at => @now,
      :updated_at => @now
    })

    @t_2 = Transaction.new({
      :id => 2,
      :invoice_id => 2,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => :success,
      :created_at => @now,
      :updated_at => @now
    })

    @transactions.instances << @t_1
    @transactions.instances << @t_2
  end
end
