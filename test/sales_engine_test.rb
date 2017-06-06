require 'pry'
require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < MiniTest::Test

  def setup
    @files = {:items => './test/data/items_test.csv',
              :merchants => './test/data/merchants_test.csv',
              :invoices => './test/data/invoices_test.csv',
              :invoice_items => './test/data/invoice_items_test.csv',
              :transactions  => './test/data/transactions_test.csv',
              :customers     => './test/data/customers_test.csv'}

    @files_2 = {:items => './test/data/items_test.csv',
              :merchants => './test/data/merchants_test_3.csv',
              :invoices => './test/data/invoices_test.csv',
              :invoice_items => './test/data/invoice_items_test.csv',
              :transactions  => './test/data/transactions_test.csv',
              :customers     => './test/data/customers_test.csv'}
  end

  def test_from_csv_creates_an_instance_of_sales_engine
    se = SalesEngine.from_csv(@files)

    assert_instance_of SalesEngine, se
  end

  def test_merchant_repo_creates
    se = SalesEngine.from_csv(@files)
    mr = se.merchants

    assert_instance_of MerchantRepository, mr
  end

  def test_items_repo_creates
    se = SalesEngine.from_csv(@files)
    ir = se.items

    assert_instance_of ItemRepository, ir
  end

  def test_if_pull_items_by_merchant_id
    se = SalesEngine.from_csv(@files)
    actual = se.items_by_merchant_id(12334105).length

    assert_equal 1, actual
  end

  def test_if_pull_merchant_by_merchant_id
    se = SalesEngine.from_csv(@files)
    actual = se.merchant_by_merchant_id(12334105)

    assert_instance_of Merchant, actual
  end

  def test_if_pull_invoices_by_merchant_id
    se = SalesEngine.from_csv(@files_2)
    merchant = se.merchants.find_by_id(12334389)
    actual = merchant.invoices.length

    assert_equal 1, actual
  end

  def test_items_by_invoice_id
    se = SalesEngine.from_csv(@files_2)

    actual_1 = se.items_by_invoice_id(12)
    actual_2 = se.items_by_invoice_id(32)

    assert_equal 1, actual_1.length
    assert [], actual_2
  end

  def test_transactions_by_invoice_id
    se = SalesEngine.from_csv(@files_2)

    actual = se.transactions_by_invoice_id(12)
    expected = se.transactions.all[9]

    assert_equal [expected], actual
  end

  def test_customer_by_customer_id
    se = SalesEngine.from_csv(@files_2)

    actual = se.customer_by_customer_id(1)
    expected = se.customers.all[0]

    assert_equal expected, actual
  end

  def test_invoice_by_invoice_id
    se = SalesEngine.from_csv(@files_2)

    transaction = se.transactions.find_by_id(10)
    actual = transaction.invoice
    expected = se.invoices.all[11]

    assert_equal expected, actual
  end

  def test_customer_by_merchant_id
    se = SalesEngine.from_csv(@files_2)

    merchant = se. merchants.find_by_id(12335938)
    actual = se.customers_by_merchant_id(12335938)
    expected = [se.customers.all[0]]
    assert_equal expected, actual
  end

  def test_merchants_by_customer_id_array_of_merchants
    se = SalesEngine.from_csv(@files_2)
    actual = se.merchants_by_customer_id(2)
    expected = [se.merchants.all[3]]

    assert_equal expected, actual
  end
end
