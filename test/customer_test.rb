require_relative 'test_helper'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

# Test Customer class
class CustomerTest < Minitest::Test
  def setup
    @time = Time.now
    @cust = Customer.new(
      id:           3,
      first_name:   "Joan",
      last_name:    "Clarke",
      created_at:   @time,
      updated_at:   @time
    )
  end

  def test_it_exists
    assert_instance_of Customer, @cust
  end

  def test_it_has_attributes
    assert_equal 3, @cust.id
    assert_equal "Joan", @cust.first_name
    assert_equal "Clarke", @cust.last_name
    assert_equal @time, @cust.created_at
    assert_equal @time, @cust.updated_at
  end
end
