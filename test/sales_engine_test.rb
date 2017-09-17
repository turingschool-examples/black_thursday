require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require 'pry'
class SalesEngineTest < MiniTest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.new({merchants:"./data/merchants.csv",
    items:"./data/items.csv",
    invoices:"./data/invoices.csv",
    invoice_items:"./data/invoice_items.csv",
    transactions:"./data/transactions.csv",
    customers:"./data/customers.csv"})
  end

  def test_it_exists
    assert_instance_of SalesEngine, se
  end

  def test_merchants_method
    assert_instance_of MerchantRepo, se.merchants
  end

  def test_items_method
    assert_instance_of ItemRepo, se.items
  end

  def test_merchant_items
    merchant = se.merchants.find_by_id(12334112)

    assert_equal 1, merchant.items.count
  end

  def test_item_merchant
    item = se.items.find_by_id(263395237)

    assert_equal 12334141, item.merchant.id
  end

  def test_merchant_invoices
    merchant = se.merchants.find_by_id(12334159)

    assert_equal 13, merchant.invoices.count
  end

  def test_invoice_merchant
    invoice = se.invoices.find_by_id(20)

    assert_equal 12336163, invoice.merchant.id
  end

  def test_invoice_items_list
    invoice = se.invoices.find_by_id(20)

    assert_instance_of Item, invoice.items[0]
    assert_equal 5, invoice.items.count
  end

  def test_invoice_transactions
    invoice = se.invoices.find_by_id(20)

    assert_equal 3, invoice.transactions.count
  end

  def test_invoice_customer
    invoice = se.invoices.find_by_id(106)

    assert_equal 22, invoice.customer.id
    assert_instance_of Customer, invoice.customer
  end

  def test_transaction_invoice
    transaction = se.transactions.find_by_id(40)

    assert_instance_of Invoice, transaction.invoice
  end

  def test_merchant_customers
    merchant = se.merchants.find_by_id(12335938)

    assert_equal 16, merchant.customers.count
  end

  def test_customer_merchants
    customer = se.customers.find_by_id(30)

    assert_equal 5, customer.merchants.count
  end
end
