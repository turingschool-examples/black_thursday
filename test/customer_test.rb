require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer'

class CustomerTest < Minitest::Test

  def test_it_exist
    customer = Customer.new({
                              :id => 6,
                              :first_name => "Joan",
                              :last_name => "Clarke",
                              :created_at => Time.now,
                              :updated_at => Time.now })

    assert_instance_of Customer, customer
  end

  def test_customer_has_id
    customer = Customer.new({
                              :id => 6,
                              :first_name => "Joan",
                              :last_name => "Clarke",
                              :created_at => Time.now,
                              :updated_at => Time.now })

    assert_equal 6, customer.id
  end

  def test_customer_has_first_name
    customer = Customer.new({
                              :id => 6,
                              :first_name => "Joan",
                              :last_name => "Clarke",
                              :created_at => Time.now,
                              :updated_at => Time.now })

    assert_equal "Joan", customer.first_name
  end

  def test_customer_has_last_name
    customer = Customer.new({
                              :id => 6,
                              :first_name => "Joan",
                              :last_name => "Clarke",
                              :created_at => Time.now,
                              :updated_at => Time.now })

    assert_equal "Clarke", customer.last_name
  end

  def test_customer_has_created_time
    customer = Customer.new({
                              :id => 6,
                              :first_name => "Joan",
                              :last_name => "Clarke",
                              :created_at => Time.now,
                              :updated_at => Time.now })

    assert_equal Time, customer.created_at
  end

  def test_customer_has_updated_time
    customer = Customer.new({
                              :id => 6,
                              :first_name => "Joan",
                              :last_name => "Clarke",
                              :created_at => Time.now,
                              :updated_at => Time.now })

    assert_equal Time, customer.updated_at
  end

end
