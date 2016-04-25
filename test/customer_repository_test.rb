require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < MiniTest::Test

  attr_reader :cr

  def setup
    test_helper = TestHelper.new
    @cr = CustomerRepository.new(test_helper.customers)
  end

  def test_it_can_return_an_array_of_all_customers
    assert_equal 3, cr.all.size
  end

  def test_it_returns_a_customer_for_a_given_id
    assert_equal 8, cr.find_by_id(8).id
  end

  def test_it_can_find_customers_by_first_name
    assert_equal 1, cr.find_all_by_first_name("Ann").count
  end

  def test_it_can_find_customers_by_first_name_in_an_array
    assert_equal Array, cr.find_all_by_first_name("Ann").class
  end

  def test_it_can_find_customers_by_last_name
    assert_equal 1, cr.find_all_by_last_name("Soden").count
  end

  def test_it_can_find_customers_by_last_name_in_an_array
    assert_equal Array, cr.find_all_by_last_name("Soden").class
  end

  def test_it_can_be_inspected
    assert_equal "#<CustomerRepository 3 rows>", cr.inspect
  end
end
