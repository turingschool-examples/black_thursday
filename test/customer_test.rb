require_relative 'test_helper'
require_relative '../lib/customer'
require_relative 'sales_engine_methods'

class CustomerTest < Minitest::Test
  include SalesEngineMethods

  attr_reader :c, :se

  def setup
    create_sales_engine
    @c = Customer.new({
      :id => 2,
      :first_name => "Cecelia",
      :last_name => "Osinski",
      :created_at => "2012-03-27 14:54:10 UTC",
      :updated_at => "2012-03-27 14:54:10 UTC"
      }, "customer_repo")
  end

  def test_it_exists
    assert_instance_of Customer, c
  end

  def test_it_knows_id
    assert_equal 2, c.id
  end

  def test_it_knows_first_name
    assert_equal "Cecelia", c.first_name
  end

  def test_it_knows_last_name
    assert_equal "Osinski", c.last_name
  end

  def test_it_knows_when_it_was_created
    assert_instance_of Time, c.created_at
    assert_equal 2012, c.created_at.year
  end

  def test_it_knows_when_it_was_last_updated
    assert_instance_of Time, c.updated_at
    assert_equal 03, c.updated_at.month
  end

  def test_it_knows_customer_repo
    assert_equal "customer_repo", c.customer_repo
  end

  def test_it_can_find_merchants_for_given_customer
    customer = se.customers.find_by_id(1)

    assert_instance_of Array, customer.merchants
    assert_equal 5, customer.merchants.count
  end

end
