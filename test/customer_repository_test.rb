require_relative 'test_helper'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'

class CustomerRepositoryTest < Minitest::Test 
  attr_reader :customer_repo
  def setup 
    @customer_repo = CustomerRepository.new('data/customers.csv')
  end
  
  def test_it_exists 
    assert_instance_of CustomerRepository, customer_repo
  end

  def test_parent_nil_default
    assert_nil customer_repo.parent
  end

  def test_all_returns_all_customer_instances 
    assert_equal 1000, customer_repo.all.length 
    assert_instance_of Customer, customer_repo.all.first 
  end

  def test_find_by_id_returns_customer_with_id 
    id       = 100 
    expected = customer_repo.find_by_id(id)

    assert_instance_of Customer, expected
  end

  def test_find_all_by_first_name_returns_customers
    fragment = "oe"
    expected = customer_repo.find_all_by_first_name(fragment)
    
    assert_equal 8, expected.length
    assert_instance_of Customer, expected.first
  end

  def test_find_all_by_last_name_returns_customers
    fragment = "On"
    expected = customer_repo.find_all_by_last_name(fragment)
    
    assert_equal 85, expected.length
    assert_instance_of Customer, expected.first
  end

  def test_find_by_name_methods_are_case_insensitive 
    fragment = 'NN'
    expected = customer_repo.find_all_by_first_name(fragment)

    assert_equal 57, expected.length

    fragment = 'oN'
    expected = customer_repo.find_all_by_last_name(fragment)

    assert_equal 85, expected.length
  end
end