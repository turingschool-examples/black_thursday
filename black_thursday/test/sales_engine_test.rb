require_relative 'test_helper'
require 'csv'
require_relative './../lib/merchant_repository'
require_relative './../lib/item_repository'
require_relative './../lib/invoice_repository'
require_relative './../lib/transaction_repository'
require_relative './../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  attr_reader :engine

  def setup
    @engine = SalesEngine.from_csv(
      items: './test/fixtures/truncated_items.csv',
      merchants: './test/fixtures/truncated_merchants.csv',
      invoices: './test/fixtures/truncated_invoices.csv',
      invoice_items: './test/fixtures/truncated_invoice_items.csv',
      transactions: './test/fixtures/truncated_transactions.csv',
      customers: './test/fixtures/truncated_customers.csv'
    )
  end

  def test_it_loads_a_merchant_repository
    assert_equal 60, @engine.merchants.all.count
  end

  def test_it_loads_an_item_repository
    assert_equal 21, @engine.items.all.count
  end

  def test_it_loads_a_invoice_repository
    assert_equal 101, @engine.invoices.all.count
  end

  def test_it_can_find_merchant_by_id
    merchant = @engine.merchants.find_by_id(12334185)

    assert_equal "Madewithgitterxx", merchant.name
    assert_equal 6, merchant.items.length
    assert_equal 263499920, merchant.items.first.id
  end

  def test_it_cant_find_merchant_by_id_if_nil
    merchant = @engine.merchants.find_by_id(nil)

    assert_nil merchant
  end

  def test_it_can_find_item_by_id
    item = @engine.items.find_by_id(263499920)

    assert_equal "Madewithgitterxx", item.merchant.name
    assert_equal Merchant, item.merchant.class
    assert_equal 12334185 , item.merchant.id
  end

  def test_it_cant_find_item_by_id_if_nil
    item = @engine.items.find_by_id(nil)

    assert_nil item
  end

  def test_it_can_find_invoices_by_id
    invoice = @engine.invoices.find_by_id(23)

    assert_instance_of Time, invoice.created_at
    assert_equal Invoice, invoice.class
    assert_equal 12336652, invoice.merchant_id
  end

  def test_find_customer_by_invoice_id
    assert_instance_of Customer, engine.find_customer_by_invoice_id(2)
    assert_equal 3, engine.find_customer_by_invoice_id(3).id
  end

  def test_find_invoice_by_transaction_id
    assert_instance_of Invoice, engine.find_invoice_by_transaction_id(1)
    assert_equal 1, engine.find_invoice_by_transaction_id(1).id
    assert_equal 12335938, engine.find_invoice_by_transaction_id(1).merchant_id
  end

  def test_find_invoice_item_by_invoice_id
    assert_instance_of Array, engine.find_invoice_item_by_invoice_id(2)
    assert_instance_of InvoiceItem, engine.find_invoice_item_by_invoice_id(2)[0]
    assert_equal 9, engine.find_invoice_item_by_invoice_id(2)[0].id
  end

  def test_find_invoices_by_merchant
    assert_instance_of Array, engine.find_invoices_by_merchant(12335938)
    assert_instance_of Invoice, engine.find_invoices_by_merchant(12335938).first
    assert_equal 9, engine.find_invoices_by_merchant(12336965).last.id
  end
end
