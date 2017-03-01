require './test/test_helper'
require './lib/customer'
require './lib/sales_engine'

class CustomerTest < Minitest::Test
  include SalesEngineTestSetup

  def setup
    super
    @c = @se.customers.all.first
  end

  def test_it_exists
    assert_instance_of Customer, @c
  end

  def test_ivars
    assert_equal 1, @c.id
    assert_equal "Joey", @c.first_name
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), @c.created_at
  end

  def test_customer_has_merchants
    skip
    customer = @se.customers.find_by_id(30)

    assert_instance_of Array, customer.merchants
    assert_instance_of Merchant, customer.merchants.first
  end

end
