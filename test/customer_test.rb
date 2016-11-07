require_relative 'test_helper'
require_relative '../lib/customer'
require_relative '../lib/data_parser'

class CustomerTest < Minitest::Test
  include DataParser
  def test_customer_class_exists
    assert_instance_of Customer, Customer.new({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
    })
  end

  def test_it_can_access_customer_attributes
    c = Customer.new({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
    })
    assert_equal 6, c.id
    assert_equal "Joan", c.first_name
    assert_equal "Clarke", c.last_name
    assert_instance_of Time, c.created_at
    assert_instance_of Time, c.updated_at
  end

  def test_it_can_parse_rows
    file = './data/customers.csv'
    assert_instance_of Array, parse_data(file)
  end
end
