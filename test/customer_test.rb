require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer'
#require './lib/customer_repository'
require './lib/sales_engine'

class CustomerTest < Minitest::Test
  attr_reader   :customer,
                :customer_2
                #:repository

  def setup
    #@repository = CustomerRepository.new('./fixture/customers.csv')
    @customer = Customer.new({
      :id => "1",
      :first_name => "Daniel",
      :last_name => "Rodriguez",
      :created_at => "2015-01-01 11:11:37 UTC",
      :updated_at => "2015-10-10 11:11:37 UTC"
    })

    @customer_2 = Customer.new({
      :id => "2",
      :first_name => "Marisa",
      :last_name => "Burton",
      :created_at => "2015-01-01 11:11:37 UTC",
      :updated_at => "2015-10-10 11:11:37 UTC"
    })
  end

  def test_it_can_create_a_customer
    assert customer
    assert customer_2
  end

  def test_it_can_return_id
    assert_equal 1, customer.id
    assert_equal 2, customer_2.id
  end

  def test_it_can_return_first_name
    assert_equal "Daniel", customer.first_name
    assert_equal "Marisa", customer_2.first_name
  end

  def test_it_can_return_last_name
    assert_equal "Rodriguez", customer.last_name
    assert_equal "Burton", customer_2.last_name
  end

  def test_it_can_return_created_at_as_time
    assert_instance_of Time, customer.created_at
    assert_instance_of Time, customer_2.created_at
  end

  def test_it_can_return_updated_at_as_time
    assert_instance_of Time, customer.updated_at
    assert_instance_of Time, customer_2.updated_at
  end

  def test_that_a_customer_knows_who_its_parent_is
    skip
    assert_equal repository, customer.parent
    assert_instance_of CustomerRepository, customer.parent
  end

end