# frozen_string_literal: false

require_relative 'test_helper'
require './lib/customer'

class CustomerTest < Minitest::Test
  def setup
    @args = { id: '1234',
              first_name:  'Bob',
              last_name:   'Smith',
              created_at:  '2016-01-11 09:34:06 UTC',
              updated_at:  '2007-06-04 21:35:10 UTC' }
    @customer = Customer.new(@args)
  end

  def test_it_exits
    assert_instance_of Customer, @customer
  end

  def test_it_has_attributes
    assert_equal 'Bob', @customer.first_name
    assert_equal 'Smith', @customer.last_name
    assert_equal 1_234, @customer.id
  end

  def test_time_attributes_for_created_at
    assert_instance_of Time, @customer.created_at
    assert_equal 2_016, @customer.created_at.year
    assert_equal 34, @customer.created_at.min
  end

  def test_time_attributes_for_updated_at
    assert_instance_of Time, @customer.updated_at
    assert_equal 6, @customer.updated_at.mon
    assert_equal 21, @customer.updated_at.hour
  end
end
