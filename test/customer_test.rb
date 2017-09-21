require_relative 'test_helper'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class CustomerTest < Minitest::Test
attr_reader :set_up, :customer_info
  def set_up
    @customer_info = {:id => 2, :first_name => "Cecelia", :last_name => "Osinski", :created_at => "2012-03-27 14:54:10 UTC", :updated_at => "2012-03-27 14:54:10 UTC"}
    customer_1 = Customer.new(customer_info, [])
  end

  def test_it_exists
    assert_instance_of Customer, set_up
  end

  def test_it_has_id
    assert_equal 2, set_up.id
  end

  def test_it_has_a_first_name
    assert_equal "Cecelia", set_up.first_name
  end

  def test_it_has_a_last_name
    assert_equal "Osinski", set_up.last_name
  end

  def test_it_has_a_created_at
    assert_instance_of Time, set_up.created_at
  end

  def test_it_has_an_updated_at
    assert_instance_of Time, set_up.updated_at
  end
end
