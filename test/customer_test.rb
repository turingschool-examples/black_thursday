require_relative 'test_helper'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class CustomerTest < Minitest::Test
attr_reader :customer_1, :customer_info
  def set_up
    @customer_info = {:id => 2, :first_name => "Cecelia", :last_name => "Osinski", :created_at => "2012-03-27 14:54:10 UTC", :updated_at => "2012-03-27 14:54:10 UTC"}
    @customer_1 = Customer.new(customer_info, [])
  end

  def test_it_exists
    set_up

    assert_instance_of Customer, customer_1
  end

  def test_it_contains_customers
    set_up

    assert_equal customer_info, customer_1.customer
  end

  def test_it_has_id
    set_up

    assert_equal 2, customer_1.id
  end

  def test_it_has_a_first_name
    set_up

    assert_equal "Cecelia", customer_1.first_name
  end

  def test_it_has_a_last_name
    set_up

    assert_equal "Osinski", customer_1.last_name
  end

  def test_it_has_a_created_at
    set_up

    assert_instance_of Time, customer_1.created_at
  end

  def test_it_has_an_updated_at
    set_up

    assert_instance_of Time, customer_1.updated_at
  end

end
