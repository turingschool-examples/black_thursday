require_relative 'test_helper'
require_relative '../lib/customer'

class CustomerTest < MiniTest::Test

  attr_reader    :customer

  def setup
    @customer = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"
    })
  end

  def test_customer_exists
    assert_instance_of Customer, customer
  end

  def test_customer_has_attributes
    assert_equal 6, customer.id
    assert_equal "Joan", customer.first_name
    assert_equal "Clarke", customer.last_name
    assert_equal "2012-03-27 14:54:09 UTC", customer.created_at.to_s
    assert_equal "2012-03-27 14:54:09 UTC", customer.updated_at.to_s
  end

end
