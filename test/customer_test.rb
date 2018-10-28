require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer'
require 'time'

class CustomerTest < Minitest::Test
  def test_customers_exists
    c = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now.to_s,
      :updated_at => Time.now.to_s
    })
    assert_instance_of Customer, c
  end

  def test_a_customer_has_attributes
    c = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now.to_s,
      :updated_at => Time.now.to_s
    })
    assert_equal 6 , c.id
    assert_equal "Joan" , c.first_name
    assert_equal "Clarke" , c.last_name
    assert_instance_of Time , c.created_at
    assert_instance_of Time , c.updated_at
  end
end
