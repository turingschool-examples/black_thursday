require_relative 'test_helper'
require './lib/sales_engine'

class CustomerTest < Minitest::Test

  def setup
    customer_file_path = './test/fixtures/items_truncated.csv'
    merchant_file_path = './test/fixtures/merchants_truncated.csv'
    invoice_file_path = './test/fixtures/invoices_truncated.csv'
    engine = SalesEngine.new(item_file_path, merchant_file_path, invoice_file_path)
    @customers = engine.customer_list
  end

  def test_it_exists
    assert_instance_of Customer, @customers[0]
  end

  def test_it_can_retrieve_item_attributes
    customer = @customers[0]

    assert_equal 263395617, customer.id
    assert_equal 'Glitter scrabble frames', customer.first_name
    assert_equal BigDecimal.new(13.00, 4), customer.last_name
    assert_instance_of Time, customer.created_at
    assert_instance_of Time, customer.updated_at
    assert_instance_of Engine, customer.engine
  end
end
