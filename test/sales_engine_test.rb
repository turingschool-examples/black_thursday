require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @information = {
      items: './test/fixtures/items_list_truncated.csv',
      merchants: './test/fixtures/merchants_list_truncated.csv',
      invoices: './test/fixtures/invoices_list_truncated.csv',
      invoice_items: './test/fixtures/invoice_items_list_truncated.csv',
      transactions: './test/fixtures/transactions_list_truncated.csv',
      customers: './test/fixtures/customer_list_truncated.csv'
    }
    @sales_engine = SalesEngine.new(@information)
  end

  def test_it_exists
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_find_items_by_merchant_id
    actual = @sales_engine.find_items_by_merchant_id(12_334_141)

    assert actual.is_a?(Array)
    assert actual[0].is_a?(Item)
    assert_equal '510+ RealPush Icon Set', actual[0].name
  end

  def test_find_invoices_by_merchant_id
    actual = @sales_engine.find_invoices_by_merchant_id(12_334_753)

    assert actual.is_a?(Array)
    assert actual[0].is_a?(Invoice)
    assert_equal 2, actual[0].id
  end

  def test_find_items_by_invoice_id
    actual = @sales_engine.find_items_by_invoice_id(74)

    assert actual.is_a?(Array)
    assert actual[0].is_a?(Item)
    assert_equal 'Knitted wool hat', actual[0].name
  end

  def test_find_transactions_by_invoice_id
    actual = @sales_engine.find_transactions_by_invoice_id(74)

    assert actual.is_a?(Array)
    assert actual[0].is_a?(Transaction)
    assert_equal 3285, actual[0].id
  end

  def test_find_customer_by_customer_id
    actual = @sales_engine.find_customer_by_customer_id(339)

    assert actual.is_a?(Customer)
    assert_equal 'Becker', actual.last_name
  end

  def test_find_invoice
    actual = @sales_engine.find_invoice(15)

    assert actual.is_a?(Invoice)
    assert_equal 3, actual.customer_id
  end

  def test_find_customers_by_merchant_id
    actual = @sales_engine.find_customers_by_merchant_id(12_335_938)

    assert actual.is_a?(Array)
    assert actual[0].is_a?(Customer)
    assert_equal 1, actual[0].id
  end

  def test_find_merchants_by_customer_id
    actual = @sales_engine.find_merchants_by_customer_id(339)

    assert actual.is_a?(Array)
    assert actual[0].is_a?(Merchant)
    assert_equal 12_334_112, actual[0].id
  end

  def test_find_transaction_payment_status
    actual = @sales_engine.find_transaction_payment_status(74)

    assert actual
  end

  def test_total_invoice_cost
    actual = @sales_engine.total_invoice_cost(74)

    assert actual.is_a?(BigDecimal)
    assert_equal 0.87909e3, actual
  end
end
