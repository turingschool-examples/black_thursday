require './test/test_helper'
require './lib/customer'

class CustomerTest < Minitest::Test
  attr_reader :customer
  def setup
    @customer = Customer.new({
                              :id => 6,
                              :first_name => "Joan",
                              :last_name => "Clarke",
                              :created_at => "2012-03-27 14:54:09 UTC",
                              :updated_at => "2012-03-27 14:54:09 UTC"
                              })
  end

  def test_that_it_exists
    assert_instance_of Customer, customer
  end

  def test_customer_has_an_id_value
    assert_equal 6, customer.id
    assert_instance_of Fixnum, customer.id
  end

  def test_customer_has_a_first_name_value
    assert_equal "Joan", customer.first_name
    assert_instance_of String, customer.first_name
  end

  def test_customer_has_a_last_name_value
    assert_equal "Clarke", customer.last_name
    assert_instance_of String, customer.last_name
  end

  def test_customer_has_a_created_at_value
    assert_instance_of Time, customer.created_at
  end

  def test_customer_has_a_updated_at_value
    assert_instance_of Time, customer.updated_at
  end

  def test_customer_has_a_parent_value
    assert_nil customer.parent
  end
end
