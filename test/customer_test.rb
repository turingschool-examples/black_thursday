require './lib/customer'
require './test/test_helper'


class CustomerTest < Minitest::Test
  def test_it_exists
    customer = Customer.new(1, "Tom", "Jones",
                            "2016-01-11 09:34:06 UTC",
                            "2016-01-11 09:34:06 UTC",
                            self)

    assert_instance_of Customer, customer
  end

  def test_it_is_created_with_state
    customer = Customer.new(1, "Tom", "Jones",
                            "2016-01-11 09:34:06 UTC",
                            "2016-01-11 09:34:06 UTC",
                            self)

    assert_equal 1, customer.id
    assert_equal "Tom", customer.first_name
    assert_equal "Jones", customer.last_name
    assert_equal Time.parse("2016-01-11 09:34:06 UTC"), customer.created_at
    assert_equal Time.parse("2016-01-11 09:34:06 UTC"), customer.updated_at
  end
end
