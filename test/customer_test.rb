# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/emoji'

require './lib/customer'

# Customer test class
class CustomerTest < Minitest::Test
  def setup
    @customer = Customer.new(
      id:          6,
      first_name:  "Joan",
      last_name:   "Clarke",
      created_at:  '2009-05-30',
      updated_at:  '2010-10-25'
    )
  end
  # Should I test specific created at times?

  def test_it_exists
    assert_instance_of Customer, @customer
  end

  def test_it_has_attributes
    assert_equal 6, @customer.id
    assert_equal "Joan", @customer.first_name
    assert_equal "Clarke", @customer.last_name
    assert_equal '2009-05-30', @customer.created_at
    assert_equal '2010-10-25', @customer.updated_at
  end

end
