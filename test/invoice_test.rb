require_relative 'test_helper'
require './lib/sales_engine'

class InvoiceTest < Minitest::Test

  def setup
    item_file_path = './test/fixtures/items_truncated.csv'
    merchant_file_path = './test/fixtures/merchants_truncated.csv'
    invoice_file_path = './test/fixtures/invoices_truncated.csv'
    invoice_item_file_path = './test/fixtures/invoice_items_truncated.csv'
    customer_file_path = './test/fixtures/customers_truncated.csv'
    transaction_file_path = './test/fixtures/transactions_truncated.csv'
    engine = SalesEngine.new(item_file_path, merchant_file_path, invoice_file_path, invoice_item_file_path, customer_file_path, transaction_file_path)
    @invoice_repo = engine.invoices
    @invoices = engine.invoice_list
  end

  def test_it_exists
    assert_instance_of Invoice, @invoices[0]
  end

  def test_it_can_retrieve_item_attributes
    invoice = @invoices[0]

    assert_equal 1495, invoice.id
    assert_equal 297, invoice.customer_id
    assert_equal :returned, invoice.status
    assert_equal 12334185, invoice.merchant_id
    assert_instance_of Time, invoice.created_at
    assert_instance_of Time, invoice.updated_at
    assert_instance_of SalesEngine, invoice.engine
  end

  def test_merchant_returns_merchant_object_with_matching_id
    invoice = @invoice_repo.find_by_id(1495)

    assert_instance_of Merchant, invoice.merchant
    assert_equal 'Madewithgitterxx', invoice.merchant.name
  end

end
