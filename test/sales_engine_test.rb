require './test/test_helper.rb'
require './lib/sales_engine.rb'

class SalesEngineTest < Minitest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoice_items => "./data/invoice_items.csv",
      :customers => "./data/customers.csv",
      :transactions => "./data/transactions.csv",
      :invoices  => "./data/invoices.csv"})
  end

  # def test_sales_engine_from_csv_creates_se_object
  #   assert_equal Class, @se.class
  # end

  # def test_it_creates_repos
  #   assert_equal MerchantRepository, @se.merchants.class
  #   assert_equal ItemRepository, @se.items.class
  #   assert_equal InvoiceRepository, @se.invoices.class
  #   assert_equal InvoiceItemRepository, @se.invoice_items.class
  #   assert_equal TransactionRepository, @se.transactions.class
  #   assert_equal CustomerRepository, @se.customers.class
  # end

  # def test_find_connections_from_invoice
  #   invoice = @se.invoices.find_by_id(20)
  #   assert_equal 5, invoice.items.length 
  #   assert_instance_of Item, invoice.items.last
  #   # => [item, item, item]
  # end

  # def test_find_connections_from_transactions 
  #   invoice = @se.invoices.find_by_id(20)
  #   assert_equal 3, invoice.transactions.length 
  #   assert_instance_of Transaction, invoice.transactions.last
  # end

  # def test_find_connections_from_customer 
  #   invoice = @se.invoices.find_by_id(20)
  #   assert_instance_of Customer, invoice.customer
  # end

  # def test_find_invoice_by_transaction
  #   transaction = @se.transactions.find_by_id(20)
  #   assert_instance_of Invoice, transaction.invoice 
  # end
  
  # def test_find_customer_from_merchant 
  #   merchant = @se.merchants.find_by_id(12335938)
  #   assert_equal 16, merchant.customers.length 
  #   assert_instance_of Customer, merchant.customers.last
  # end

  # def test_find_all_paid_in_full
  #   invoice = @se.invoices.find_by_id(1)
  #   assert invoice.is_paid_in_full?
  # end

  # def test_total
  #   invoice = @se.invoices.find_by_id(1)
  #   assert_equal 21067.77, invoice.total.to_f
  # end

  def test_it_can_find_merchant_revenue
    merchant = @se.merchants.find_by_id(12337339)
    assert_equal 7845, merchant.merchant_revenue
  end
end
