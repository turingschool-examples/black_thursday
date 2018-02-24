require_relative 'test_helper'
require_relative '../lib/customer'
require 'time'

class CustomerTest < Minitest::Test

  def setup
    data = {
      id:           6,
      first_name:   "Joan",
      last_name:    "Clarke",
      created_at:   "2018-02-02 14:37:20 -0700",
      updated_at:   "2018-02-02 14:37:20 -0700"}
    @customer = Customer.new(data)
  end

  def test_if_it_exists
    assert_instance_of Customer, @customer
  end

  def test_if_it_has_attributes
    assert_equal 6, @customer.id
    assert_equal "Joan", @customer.first_name
    assert_equal "Clarke", @customer.last_name
    assert @customer.created_at.class == Time
    assert @customer.updated_at.class == Time
  end

end
