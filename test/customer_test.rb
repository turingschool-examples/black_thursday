require_relative './test_helper'
require './lib/customer'

class CustomerTest < Minitest::Test
  def test_it_exists
    customer = Customer.new(
      {
        :id => 5,
        :first_name => "Jane",
        :last_name => "Doe",
        :created_at => "2010-12-10",
        :updated_at => "2011-12-04"
        }
      )

    assert_instance_of Customer, customer
  end

  def test_it_has_attributes
    customer = Customer.new(
      {
        :id => 5,
        :first_name => "Jane",
        :last_name => "Doe",
        :created_at => "2010-12-10",
        :updated_at => "2011-12-04"
        }
      )

    assert_equal 5, customer.id
    assert_equal "Jane", customer.first_name
    assert_equal "Doe", customer.last_name
    assert_equal Time, customer.created_at.class
    assert_equal Time, customer.updated_at.class
  end

end
