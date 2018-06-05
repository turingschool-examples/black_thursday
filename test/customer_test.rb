require_relative 'test_helper'
require './lib/sales_engine'
require './lib/customer'

class CustomerTest < Minitest::Test

  def setup
    @args = {
             :id => 6,
             :first_name => 'Joan',
             :last_name => 'Clarke',
             :created_at  => '2016-01-11 09:34:06 UTC',
             :updated_at  => '2007-06-04 21:35:10 UTC'
            }
    @customer = Customer.new(@args)
  end

  def test_it_exists
    assert_instance_of Customer, @customer
  end

  def test_it_has_attributes
    assert_equal 6, @customer.id
    assert_equal 'Joan', @customer.first_name
    assert_equal 'Clarke', @customer.last_name
  end

  def test_time_attributes
    assert_instance_of Time, @customer.created_at
    assert_equal 2016, @customer.created_at.year
    assert_equal 9, @customer.created_at.hour

    assert_instance_of Time, @customer.updated_at
    assert_equal 06, @customer.updated_at.month
    assert_equal 35, @customer.updated_at.min
  end

end
