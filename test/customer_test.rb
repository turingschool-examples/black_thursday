require_relative 'test_helper'
require_relative '../lib/customer'
require 'time'

class CustomerTest < Minitest::Test
  def setup
    @data = {
      id: 6,
      first_name: 'Joan',
      last_name: 'Clarke',
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2012-03-27 14:54:09 UTC'
    }
    @customer = Customer.new(@data, 'CustomerRepository pointer')
  end

  def test_it_exists
    assert_instance_of Customer, @customer
  end

  def test_it_initializes_with_information
    assert_equal 6, @customer.id
    assert_equal 'Joan', @customer.first_name
    assert_equal 'Clarke', @customer.last_name
    assert_equal Time.utc(2012, 3, 27, 14, 54, 9), @customer.created_at
    assert_equal Time.utc(2012, 3, 27, 14, 54, 9), @customer.updated_at
    assert_equal 'CustomerRepository pointer', @customer.parent
  end
end
