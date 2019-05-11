require 'time'
require_relative 'test_helper'
require_relative '../lib/elementals/customer'

# customer class
class CustomerTest < Minitest::Test
  def setup
    @time = Time.now.to_s
    @customer = Customer.new(id: 5,
                             first_name: 'Cole',
                             last_name: 'Hart',
                             created_at: @time,
                             updated_at: @time)
  end

  def test_customer_exists
    assert_instance_of Customer, @customer
  end

  def test_customer_has_id
    assert_equal 5, @customer.id
  end

  def test_customer_has_first_name
    assert_equal 'Cole', @customer.first_name
  end

  def test_customer_has_last_name
    assert_equal 'Hart', @customer.last_name
  end

  def test_it_has_created_at
    assert_equal Time.parse(@time), @customer.created_at
  end

  def test_it_has_updated_at
    assert_equal Time.parse(@time), @customer.updated_at
  end
end
