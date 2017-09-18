require_relative 'test_helper'
require './lib/sales_engine'

class CustomerTest < Minitest::Test

  def setup
    item_file_path = './test/fixtures/items_truncated.csv'
    merchant_file_path = './test/fixtures/merchants_truncated.csv'
    invoice_file_path = './test/fixtures/invoices_truncated.csv'
    invoice_item_file_path = './test/fixtures/invoice_items_truncated.csv'
    customer_file_path = './test/fixtures/customers_truncated.csv'
    transaction_file_path = './test/fixtures/transactions_truncated.csv'
    engine = SalesEngine.new(item_file_path, merchant_file_path, invoice_file_path, invoice_item_file_path, customer_file_path, transaction_file_path)
    @customers = engine.customer_list
  end

  def test_it_exists
    assert_instance_of Customer, @customers[0]
  end

  def test_it_can_retrieve_item_attributes
    customer = @customers[0]

    assert_equal 297, customer.id
    assert_equal 'Nathanael', customer.first_name
    assert_equal 'Ernser', customer.last_name
    assert_instance_of Time, customer.created_at
    assert_instance_of Time, customer.updated_at
    assert_instance_of SalesEngine, customer.engine
  end
end
