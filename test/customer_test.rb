require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test

  def setup
    @customer = Customer.new({
      :id => 1,
      :first_name => "Napoleon",
      :last_name => "Bonaparte",
      :created_at => Time.now,
      :updated_at => Time.now,
      })
  end

  def test_it_exists
    assert_instance_of Customer, @customer
  end

  def test_it_has_attributes
    assert_equal 1, @customer.id
    assert_equal "Napoleon", @customer.first_name
    assert_equal "Bonaparte", @customer.last_name
    assert_instance_of Time, @customer.created_at
    assert_instance_of Time, @customer.updated_at
  end
end
