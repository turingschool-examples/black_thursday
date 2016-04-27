require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/csv_parser'
require_relative'../lib/merchant_repository'
require_relative'../lib/transaction_repository'
require_relative'../lib/customer_repository'
require_relative'../lib/invoice_item_repository'

class SalesEngineTest < MiniTest::Test
   attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./test/test_csvs/items_test.csv",
      :merchants => "./test/test_csvs/merchants_test.csv",
      :invoices  => "./test/test_csvs/invoices_test.csv",
      :invoice_items => "./test/test_csvs/invoice_items_test.csv",
      :transactions => "./test/test_csvs/transactions_test.csv",
      :customers => "./test/test_csvs/customers_test.csv",
    })
  end

  def test_it_creates_instance
    assert se
  end

  def test_it_creates_item_repository_instance
    assert se.items
  end

  def test_it_creates_merchant_repository_instance
    assert se.merchants
  end

  def test_it_creates_invoice_item_repository_instance
    assert se.invoice_items
  end

  def test_it_creates_transaction_repository_instance
    assert se.transactions
  end

  def test_it_creates_customer_repository_instance
    assert se.customers
  end

  def test_it_creates_invoice_repository_instance
    assert se.invoices
  end

  def test_it_finds_items_by_merchant_id
    assert_equal 7, se.items_by_merchant_id(12334113).length
  end

  def test_it_finds_in_merchant_repository
    mr = se.merchants
    assert_equal "Shopin1901", mr.find_by_name("Shopin1901").name
  end

  def test_it_finds_in_item_repository
    ir = se.items
    assert_equal "Glitter scrabble frames", ir.find_by_name("Glitter scrabble frames").name
  end

  def test_it_links_merchants_to_items
    refute se.items.all.first.merchant.nil?
  end

  def test_it_finds_items_for_merchant
    merchant = se.merchants.find_by_id(12334105)
    assert_equal 12, merchant.items.count
  end

  def test_it_finds_merchant_of_item
    item = se.items.find_by_id(223456789)
    assert_equal 12334105, item.merchant.id
  end

  def test_it_finds_merchant_of_invoice
    invoice = se.invoices.find_by_id(4)
    assert_equal "MiniatureBikez", invoice.merchant.name
  end

  def test_it_finds_invoices_for_merchant
    merchant = se.merchants.find_by_id(12334105)
    assert_equal 2, merchant.invoices.count
  end

  def test_it_finds_invoice_items_for_invoice
    invoice = se.invoices.find_by_id(7)
    assert_equal 4, invoice.invoice_items.count
  end

  def test_it_finds_items_for_invoice
    invoice = se.invoices.find_by_id(7)
    assert_equal 4, invoice.items.count
  end

  def test_it_finds_transactions_for_invoice
    invoice = se.invoices.find_by_id(1)
    assert_equal 2, invoice.transactions.count
  end

  def test_it_finds_customer_for_invoice
    invoice = se.invoices.find_by_id(5)
    assert_equal "Joey", invoice.customer.first_name
  end

  def test_it_finds_customers_for_merchants
    merchant = se.merchants.find_by_id(12334113)
    assert_equal 1, merchant.customers.count
  end

end
