require 'bigdecimal'
require 'time'

require './test/test_helper'
require './lib/customer'

class CustomerTest < Minitest::Test

  def new_customer(data)
    Fixture.new_record(:customers, data)
  end

  def customer_14
    Fixture.find_record(:customers, 14)
  end

  def customer_14_expected
    {
      id:           14,
      first_name:  'Casimer',
      last_name:   'Hettinger',
      created_at:   Time.parse('2012-03-27 14:54:13 UTC'),
      updated_at:   Time.parse('2012-03-27 14:54:13 UTC')
    }
  end

def test_initialize_takes_a_hash_of_strings
  assert_instance_of Customer, new_customer({
    id:           '14',
    first_name:  'Casimer',
    last_name:   'Hettinger',
    created_at:   '2012-03-27 14:54:13 UTC',
    updated_at:   '2012-03-27 14:54:13 UTC'
    })
end

def test_it_has_an_Integer_id
  assert_equal customer_14_expected[:id], customer_14.id
end

def test_it_has_a_first_name
  assert_equal customer_14_expected[:first_name], customer_14.first_name
end

def test_it_has_a_last_name
  assert_equal customer_14_expected[:last_name], customer_14.last_name
end

def test_it_has_a_Time_created_at
  assert_equal customer_14_expected[:created_at], customer_14.created_at
end

def test_it_has_a_Time_updated_at
  assert_equal customer_14_expected[:updated_at], customer_14.updated_at
end

def test_merchants_returns_an_array_matching_merchants
  assert_instance_of Array, customer_14.merchants
  assert_instance_of Merchant, customer_14.merchants.first
end


end
