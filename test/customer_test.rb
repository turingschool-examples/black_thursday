require_relative 'test_helper'
require './lib/customer'

class CustomerTest < Minitest::Test

  def setup
    @customer = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
    })
  end

  def test_customer_class_exists
    assert_instance_of Customer, @customer
  end

  def test_customer_has_id
    assert_equal 6, @customer.id
  end

  def test_customer_has_first_name
    assert_equal "Joan", @customer.first_name
  end

  def test_customer_has_last_name
    assert_equal "Clarke", @customer.last_name
  end

  def test_customer_has_a_created_time_that_is_an_instance_of_the_time_class
    assert_instance_of Time, @customer.created_at
  end

  def test_customer_has_an_updated_time_that_is_an_instance_of_the_time_class
    assert_instance_of Time, @customer.updated_at
  end

  def test_customer_has_a_parent_defaulted_to_nil
    assert_nil @customer.parent
  end
end
