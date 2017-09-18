require_relative 'test_helper'
require './lib/sales_engine'

class InvoiceItemTest < Minitest::Test

  def setup
    item_file_path = './test/fixtures/items_truncated.csv'
    merchant_file_path = './test/fixtures/merchants_truncated.csv'
    invoice_file_path = './test/fixtures/invoices_truncated.csv'
    customer_file_path = './test/fixtures/customers_truncated.csv'
    transaction_file_path = './test/fixtures/transactions_truncated.csv'
    engine = SalesEngine.new(item_file_path, merchant_file_path, invoice_file_path, customer_file_path, transaction_file_path)
    @invoice_items = engine.invoice_items_list
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @invoice_items[0]
  end

  def test_it_can_retrieve_item_attributes
    invoice_item = @invoice_items[0]

    assert_equal 6667, invoice_item.id
    assert_equal 263443369, invoice_item.item_id
    assert_equal 1495, invoice_item.invoice_id
    assert_equal BigDecimal.new(32.321, 4), invoice_item.unit_price
    assert_equal 3, invoice_item.quantity
    assert_instance_of Time, item.created_at
    assert_instance_of Time, item.updated_at
    assert_instance_of SalesEngine, item.engine
  end
