require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    @item_1 = Item.new({:id => 263395237, :name => "Pencil", :description => "You can use it to write things", :unit_price  => BigDecimal.new(10.99,4), :merchant_id => 12334141, :created_at  => Time.now, :updated_at  => Time.now})
    @item_2 = Item.new({:id => 263395985,:name => "Marker",:description => "You can use it to write more things",:unit_price  => BigDecimal.new(12.99,4), :merchant_id => 12339191, :created_at  => Time.now,:updated_at  => Time.now})
    @item_3 = Item.new({:id => 263395234, :name => "Chapstick", :description => "Moisturizes lips.", :unit_price  => BigDecimal.new(4.55,4), :merchant_id => 12337777, :created_at  => Time.now, :updated_at  => Time.now})
    @items = [@item_1, @item_2, @item_3]

    @merchant_1 = Merchant.new({:id => 5, :name => "Turing School"})
    @merchant_2 = Merchant.new({:id => 7, :name => "G School"})
    @merchant_3 = Merchant.new({:id => 15, :name => "Denver University"})
    @merchants = [@merchant_1, @merchant_2, @merchant_3]

    @invoice_1 = Invoice.new({:id => 6, :customer_id => 26, :merchant_id => 1355, :status => "pending", :created_at => Time.now, :updated_at => Time.now})
    @invoice_2 = Invoice.new({:id => 7, :customer_id => 37, :merchant_id => 2289, :status => "pending", :created_at => Time.now, :updated_at => Time.now})
    @invoice_3 = Invoice.new({:id => 8, :customer_id => 48, :merchant_id => 4934, :status => "pending", :created_at => Time.now, :updated_at => Time.now})
    @invoices = [@invoice_1, @invoice_2, @invoice_3]

    @invoice_item_1 = InvoiceItem.new({:id => 6, :item_id => 7, :invoice_id => 88, :quantity => 1, :unit_price => BigDecimal.new(100.99, 4), :created_at => Time.now, :updated_at => Time.now})
    @invoice_item_2 = InvoiceItem.new({:id => 7, :item_id => 33, :invoice_id => 99, :quantity => 1, :unit_price => BigDecimal.new(5.99, 4), :created_at => Time.now, :updated_at => Time.now})
    @invoice_item_3 = InvoiceItem.new({:id => 8, :item_id => 7, :invoice_id => 99, :quantity => 1, :unit_price => BigDecimal.new(12.36, 4), :created_at => Time.now, :updated_at => Time.now})
    @invoice_item_4 = InvoiceItem.new({:id => 9, :item_id => 987, :invoice_id => 66, :quantity => 1, :unit_price => BigDecimal.new(9.79, 4), :created_at => Time.now, :updated_at => Time.now})
    @invoice_items = [@invoice_item_1, @invoice_item_2, @invoice_item_3, @invoice_item_4]

    @customer_1 = Customer.new({:id => 6, :first_name => "Joan", :last_name => "Clarke", :created_at => Time.now, :updated_at => Time.now})
    @customer_2 = Customer.new({:id => 33, :first_name => "Kat", :last_name => "Clarkson", :created_at => Time.now, :updated_at => Time.now})
    @customer_3 = Customer.new({:id => 12, :first_name => "Nick", :last_name => "Program", :created_at => Time.now, :updated_at => Time.now})
    @customer_4 = Customer.new({:id => 90, :first_name => "Nicolas", :last_name => "Jones", :created_at => Time.now, :updated_at => Time.now})
    @customers = [@customer_1, @customer_2, @customer_3, @customer_4]

    @transaction_1 = Transaction.new({:id => 6, :invoice_id => 8, :credit_card_number => "4242424242421111", :credit_card_expiration_date => "0220", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    @transaction_2 = Transaction.new({:id => 7, :invoice_id => 9, :credit_card_number => "4242424242422222", :credit_card_expiration_date => "0321", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    @transaction_3 = Transaction.new({:id => 8, :invoice_id => 10, :credit_card_number => "4242424242423333", :credit_card_expiration_date => "0422", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    @transaction_4 = Transaction.new({:id => 9, :invoice_id => 11, :credit_card_number => "4242424242424444", :credit_card_expiration_date => "0523", :result => "success", :created_at => Time.now, :updated_at => Time.now})
    @transactions = [@transaction_1, @transaction_2, @transaction_3, @transaction_4]

    @sales_engine = SalesEngine.new(@items, @merchants, @invoices, @invoice_items, @customers, @transactions)

    assert_instance_of SalesEngine, @sales_engine
  end

  def test_factory_method_creates_instance
    sales_engine = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          :invoices  => "./data/invoices.csv",
          :invoice_items => "./data/invoice_items.csv",
          :transactions => "./data/transactions.csv",
          :customers => "./data/customers.csv"
          })

    assert_instance_of SalesEngine, sales_engine
  end

  def test_it_creates_repository_objects
    sales_engine = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          :invoices  => "./data/invoices.csv",
          :invoice_items => "./data/invoice_items.csv",
          :transactions => "./data/transactions.csv",
          :customers => "./data/customers.csv"
          })

    assert_instance_of MerchantRepository, sales_engine.merchants
    assert_instance_of ItemRepository, sales_engine.items
    assert_instance_of InvoiceRepository, sales_engine.invoices
    assert_instance_of InvoiceItemRepository, sales_engine.invoice_items
    assert_instance_of TransactionRepository, sales_engine.transactions
    assert_instance_of CustomerRepository, sales_engine.customers
  end

  def test_it_creates_new_sales_analyst
    sales_engine = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          :invoices  => "./data/invoices.csv",
          :invoice_items => "./data/invoice_items.csv",
          :transactions => "./data/transactions.csv",
          :customers => "./data/customers.csv"
          })
    sales_analyst = sales_engine.analyst

    assert_instance_of SalesAnalyst, sales_analyst
  end
end
