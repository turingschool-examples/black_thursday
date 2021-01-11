require_relative './test_helper'
require 'time'

class CustomerTest < Minitest::Test

  def setup
    item_path          = "./data/items.csv"
    merchant_path      = "./data/merchants.csv"
    invoice_path       = "./data/invoices.csv"
    invoice_item_path  = "./data/invoice_items.csv"
    customer_path      = "./data/customers.csv"

    arguments = {
                  :items     => item_path,
                  :merchants => merchant_path,
                  :invoices  => invoice_path,
                  :invoice_items => invoice_item_path,
                  :customers => customer_path
                }
    @engine = SalesEngine.from_csv(arguments)
    @customer = @engine.customers.find_by_id(500)
  end

  def test_id_returns_the_id
    assert_equal 500, @customer.id
    assert_equal Fixnum, @customer.id.class
  end

  def test_first_name_returns_the_first_name
    assert_equal "Hailey", @customer.first_name
    assert_equal String, @customer.first_name.class
  end

  def test_last_name_returns_the_last_name
    assert_equal "Veum", @customer.last_name
     assert_equal String, @customer.last_name.class
  end

  def test_created_at_returns_a_time_instance_for_the_date_the_invoice_item_was_created
    assert_equal Time.parse("2012-03-27 14:56:08 UTC"), @customer.created_at
    assert_equal Time, @customer.created_at.class
  end

  def test_updated_at_returns_a_time_instance_for_the_date_the_invoice_item_was_last_updated
    assert_equal Time.parse("2012-03-27 14:56:08 UTC"), @customer.updated_at
    assert_equal Time, @customer.updated_at.class
  end
end
