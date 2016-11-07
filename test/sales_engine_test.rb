require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items         => "./data/test_items.csv",
      :merchants     => "./data/test_merchants.csv",
      :invoices      => "./data/test_invoices.csv",
      :invoice_items => "./data/test_invoice_items.csv",
      :transactions  => "./data/test_transactions.csv",
      :customers     => "./data/test_customers.csv"
    })
  end

  def test_it_exists
    assert SalesEngine
  end

  def test_class_method_intializes_instance
    assert_equal SalesEngine, sales_engine.class
  end

  def test_it_intitalizes_an_item_repo_object
    assert_equal ItemRepository, sales_engine.items.class
  end

  def test_it_intitalizes_a_merch_repo_object
    assert_equal MerchantRepository, sales_engine.merchants.class
  end

  def test_it_intitalizes_an_invoice_repo_object
    assert_equal InvoiceRepository, @sales_engine.invoices.class
  end

  def test_it_intitalizes_an_invoice_item_repo_object
    assert_equal InvoiceItemRepository, @sales_engine.invoice_items.class
  end

  def test_it_intitalizes_a_transaction_repo_object
    assert_equal TransactionRepository, @sales_engine.transactions.class
  end

  def test_it_intitalizes_a_customer_repo_object
    assert_equal CustomerRepository, @sales_engine.customers.class
  end

  def test_find_items_by_merchant_id_finds_merchant
    expected = sales_engine.find_items_by_merchant_id(12334105)
    assert expected.all?{|item| item.class == Item}
    assert expected.all?{|item| item.merchant_id == 12334105}
  end

  def test_find_merchant_by_id_returns_merchant_object
    expected = sales_engine.find_merchant_by_id(12334112)
    assert_equal Merchant, expected.class
    assert_equal expected.id, sales_engine.merchants.find_by_id(12334112).id
  end

  def test_find_invoices_finds_them
    expected = sales_engine.find_invoices(12334105)
    assert expected.all?{|invoice| invoice.class == Invoice}
    assert expected.all?{|invoice| invoice.merchant_id == 12334105}
  end

  def test_find_invoice_by_id_returns_invoice_object
    expected = sales_engine.find_invoice_by_id(1)
    assert_equal Invoice, expected.class
    assert_equal expected.id, sales_engine.invoices.find_by_id(1).id
  end

  def test_find_item_by_id_returns_item_object
    expected = sales_engine.find_item_by_id(263400121)
    assert_equal Item, expected.class
    assert_equal expected.id, sales_engine.items.find_by_id(263400121).id
  end

  def test_find_customer_by_id_returns_customer_object
    expected = sales_engine.find_customer_by_id(7)
    assert_equal Customer, expected.class
    assert_equal expected.id, sales_engine.customers.find_by_id(7).id
  end

  def test_find_items_by_invoice_id_finds_them
    expected = sales_engine.find_items_by_invoice_id(14)
    assert expected.all?{|item| item.class == Item}
  end

  def test_find_transactions_by_invoice_id_finds_them
    expected = sales_engine.find_transactions_by_invoice_id(1)
    assert expected.all?{|transaction| transaction.class == Transaction}
    assert expected.all?{|transaction| transaction.invoice_id == 1}
  end

  def test_find_customers_of_merchant
    expected = sales_engine.find_customers_of_merchant(12334112)
    assert expected.all?{|customer| customer.class == Customer}    
  end

  def test_find_merchants_of_customer
    expected = sales_engine.find_merchants_of_customer(1)
    assert expected.all?{|merchant| merchant.class == Merchant}    
  end

  def test_find_invoice_items_for_invoice_finds_them
    expected = sales_engine.find_invoice_items_for_invoice(1)
    assert expected.all?{|invoice_item| invoice_item.class == InvoiceItem}
    assert expected.all?{|invoice_item| invoice_item.invoice_id == 1}
  end

  def test_all_merchants_returns_array_of_all_merchants
    assert_equal Array, sales_engine.all_merchants.class
    assert sales_engine.all_merchants.all? { |merchant| merchant.class == Merchant}
    assert_equal sales_engine.merchants.all.count, sales_engine.all_merchants.count
  end

  def test_all_items_returns_array_of_all_items
    assert_equal Array, sales_engine.all_items.class
    assert sales_engine.all_items.all? { |item| item.class == Item}
    assert_equal sales_engine.items.all.count, sales_engine.all_items.count
  end

  def test_all_invoices_returns_array_of_all_invoices
    assert_equal Array, sales_engine.all_invoices.class
    assert sales_engine.all_invoices.all? { |invoice| invoice.class == Invoice}
    assert_equal sales_engine.invoices.all.count, sales_engine.all_invoices.count
  end

  def test_all_invoice_items_returns_array_of_all_invoice_items
    assert_equal Array, sales_engine.all_invoice_items.class
    assert sales_engine.all_invoice_items.all? { |invoice_item| invoice_item.class == InvoiceItem}
    assert_equal sales_engine.invoice_items.all.count, sales_engine.all_invoice_items.count
  end

  def test_all_transactions_returns_array_of_all_transactions
    assert_equal Array, sales_engine.all_transactions.class
    assert sales_engine.all_transactions.all? { |invoice_item| invoice_item.class == Transaction}
    assert_equal sales_engine.transactions.all.count, sales_engine.all_invoice_items.count
  end

  def test_all_customers_returns_array_of_all_customers
    assert_equal Array, sales_engine.all_customers.class
    assert sales_engine.all_customers.all? { |invoice_item| invoice_item.class == Customer}
    assert_equal sales_engine.customers.all.count, sales_engine.all_invoice_items.count
  end

end
