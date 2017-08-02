require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer'

class CustomerTest < Minitest::Test

  def setup
    @customer = Customer.new({:id => 6,
                              :first_name => "Joan",
                              :last_name => "Clarke",
                              :created_at => "2012-03-27 14:54:09 UTC",
                              :updated_at => "2012-03-27 14:54:09 UTC" }, "CustomerRepository")
  end

  def test_it_exist
    assert_instance_of Customer, @customer
    assert_equal 6, @customer.id
    assert_equal "Joan", @customer.first_name
    assert_equal "Clarke", @customer.last_name
    assert_instance_of Time, @customer.created_at
    assert_instance_of Time, @customer.updated_at
  end

end
