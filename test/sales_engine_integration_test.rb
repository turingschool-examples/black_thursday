require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items            => "./data/test_items.csv",
      :merchants        => "./data/test_merchants.csv",
      :invoices         => "./data/test_invoices.csv",
      :invoice_items    => "./data/test_invoice_items.csv",
      :customers        => "./data/test_customers.csv",
      :transactions     => "./data/test_transactions.csv"
    })
  end

  def test_it_exists
    assert SalesEngine
  end

  def test_items_are_found_from_merchant_level
    merchant = sales_engine.merchants.find_by_id(12334185)
    assert_equal 3, merchant.items.count
    assert merchant.items.all?{|item| item.class == Item}
  end
  
  def test_items_are_found_from_different_merchant
    merchant = sales_engine.merchants.find_by_id(12334195)
    assert_equal 12, merchant.items.count
    assert merchant.items.all?{|item| item.class == Item}
  end

  def test_items_are_found_from_different_merchant_with_one_item
    merchant = sales_engine.merchants.find_by_id(12334257)
    assert_equal 1, merchant.items.count
    assert merchant.items.one?{|item| item.class == Item}
  end

  def test_invoices_are_found_from_merchant_level
    merchant = sales_engine.merchants.find_by_id(12334208)
    assert_equal 1, merchant.invoices.count
    assert_equal 30, merchant.invoices.first.id
    assert merchant.invoices.all?{|invoice| invoice.class == Invoice}
  end

  def test_customers_are_found_from_merchant_level
    merchant = sales_engine.merchants.find_by_id(12334208)
    assert_equal 1, merchant.customers.count
    assert_equal 7, merchant.customers.first.id
    assert merchant.customers.all?{|customer| customer.class == Customer}
  end

  def test_merchant_is_found_from_item_level
    item = sales_engine.items.find_by_id(263395237)
    assert_equal Merchant, item.merchant.class
    assert_equal 12334141, item.merchant.id
  end

  def test_merchant_is_found_from_invoice_level
    invoice = sales_engine.invoices.find_by_id(30)
    assert_equal 12334208, invoice.merchant.id
    assert_equal Merchant, invoice.merchant.class
  end

  def test_customer_is_found_from_invoice_level
    invoice = sales_engine.invoices.find_by_id(5)
    assert_equal 1, invoice.customer.id
    assert_equal Customer, invoice.customer.class
  end

  def test_transactions_are_found_from_invoice_level
    invoice = sales_engine.invoices.find_by_id(2)
    assert invoice.transactions.all? { |transaction| transaction.class == Transaction }
    assert invoice.transactions.all? { |transaction| transaction.invoice_id == 2 }
  end

  def test_items_are_found_from_invoice_level
    invoice = sales_engine.invoices.find_by_id(2)
    assert invoice.items.all? { |item| item.class == Item }
  end

  def test_invoice_is_found_from_transaction_level
    transaction = sales_engine.transactions.find_by_id(40)
    assert_equal Invoice, transaction.invoice.class
    assert_equal 14, transaction.invoice.id
  end
  
  def test_invoice_is_found_from_invoice_item_level
    invoice_item = sales_engine.invoice_items.find_by_id(1)
    assert_equal Invoice, invoice_item.invoice.class
    assert_equal 1, invoice_item.invoice.id
  end
  
  def test_item_is_found_from_invoice_item_level
    invoice_item = sales_engine.invoice_items.find_by_id(55)
    assert_equal Item, invoice_item.item.class
    assert_equal 263397059, invoice_item.item.id
  end

  def test_merchants_are_found_from_customer_level
    customer = sales_engine.customers.find_by_id(1)
    assert customer.merchants.all? { |merchant| merchant.class == Merchant }
    assert invoice.merchants.all? { |merchant| merchant.invoice_id == 2 }
  end

end
