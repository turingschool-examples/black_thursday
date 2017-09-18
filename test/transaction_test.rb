require_relative 'test_helper'
require './lib/sales_engine'

class InvoiceItemTest < Minitest::Test

  def setup
    item_file_path = './test/fixtures/items_truncated.csv'
    merchant_file_path = './test/fixtures/merchants_truncated.csv'
    invoice_file_path = './test/fixtures/invoices_truncated.csv'
    invoice_item_file_path = './test/fixtures/invoice_items_truncated.csv'
    customer_file_path = './test/fixtures/customers_truncated.csv'
    transaction_file_path = './test/fixtures/transactions_truncated.csv'
    engine = SalesEngine.new(item_file_path, merchant_file_path, invoice_file_path, invoice_item_file_path, customer_file_path, transaction_file_path)
    @transactions = engine.transaction_list
  end

  def test_it_exists
    assert_instance_of Transaction, @transactions[0]
  end

  def test_it_can_retrieve_item_attributes
    transaction = @transactions[0]

    assert_equal 531, transaction.id
    assert_equal '4134214819227763', transaction.credit_card_number
    assert_equal 1495, transaction.invoice_id
    assert_equal '1012', transaction.credit_card_expiration_date
    assert_equal 'success', transaction.result
    assert_instance_of Time, transaction.created_at
    assert_instance_of Time, transaction.updated_at
    assert_instance_of SalesEngine, transaction.engine
  end
end
