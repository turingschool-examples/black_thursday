require 'bigdecimal'
require_relative 'test_helper'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'
require_relative './master_hash'
require 'pry'

class CustomerTest < Minitest::Test
  def setup
    test_engine = TestEngine.new.god_hash
    @sales_engine = SalesEngine.new(test_engine)
    @customer = Customer.new({
      :id        => 7,
      :first_name => "Mary",
      :last_name  => "Jane",
      :created_at  => '2018-02-21 19:23:23 UTC',
      :updated_at  => '2018-02-21 19:23:23 UTC',
      }, @sales_engine.customers)
  end

  def test_it_exists
    customer = @customer

    assert_instance_of Customer, customer
  end

  def test_it_has_attributes
    assert_equal 7, @customer.id
    assert_equal "Mary", @customer.first_name
    assert_equal "Jane", @customer.last_name
    assert_instance_of Time, @customer.created_at
    assert_instance_of Time, @customer.updated_at
  end

  def test_it_can_have_different_attributes
    customer2 = Customer.new({
      :id        => 12,
      :first_name => "Bob",
      :last_name  => "Hope",
      :created_at  => '2018-12-01 19:23:23 UTC',
      :updated_at  => '2018-12-01 19:23:23 UTC',
      }, @sales_engine.customers)

    assert_equal 12, customer2.id
    assert_equal "Bob", customer2.first_name
    assert_equal "Hope", customer2.last_name
    assert_instance_of Time, customer2.created_at
    assert_instance_of Time, customer2.updated_at
  end

  def test_customer_merchant_returns_merchant_array
    customer = @sales_engine.customers.find_by_id(1)
    customer.merchants

    assert_equal 7, customer.merchants.length
    assert_instance_of Merchant, customer.merchants[0]
  end
end
