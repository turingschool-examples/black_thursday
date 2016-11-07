require_relative 'test_helper'
require_relative '../lib/customer_repo'

class CustomerRepoTest < Minitest::Test
  def test_customer_repo_class_exists
    assert_instance_of CustomerRepo, CustomerRepo.new('./data/customers.csv')
  end

  def test_customer_repo_can_populate_with_objects_and_attributes
    customer_repo = CustomerRepo.new('./data/customers.csv')
    assert_equal Customer, customer_repo.all.first.class
    assert_equal 1, customer_repo.all.first.id
    assert_equal "Joey", customer_repo.all.first.first_name
    assert_equal "Ondricka", customer_repo.all.first.last_name
    assert_instance_of Time, customer_repo.all.first.created_at
    assert_instance_of Time, customer_repo.all.first.updated_at
  end

  def test_customer_repo_can_find_all_instances_of_customer
    customer_repo = CustomerRepo.new('./data/customers.csv')
    assert_equal 1000, customer_repo.all.count
  end

  def test_customer_repo_can_find_customers_by_id
    customer = CustomerRepo.new('./data/customers.csv').find_by_id(13)
    assert_equal 13, customer.id
  end

  def test_customer_repo_returns_nil_if_customer_id_not_found
    customer = CustomerRepo.new('./data/customers.csv').find_by_id(1232)
    assert_nil customer
  end

  def test_customer_repo_can_find_all_by_first_name
    customer = CustomerRepo.new('./data/customers.csv').find_all_by_first_name("Eric")
    assert_equal 2, customer.count
  end

  def test_customer_repo_returns_an_empty_array_if_first_name_does_not_exist
    customer = CustomerRepo.new('./data/customers.csv').find_all_by_first_name("Edilene")
    assert_equal [], customer
  end

  def test_customer_repo_can_find_all_by_last_name
    customer = CustomerRepo.new('./data/customers.csv').find_all_by_last_name("Smith")
    assert_equal 3, customer.count
  end

  def test_customer_repo_returns_an_empty_array_if_last_name_does_not_exist
    customer = CustomerRepo.new('./data/customers.csv').find_all_by_last_name("Sauro")
    assert_equal [], customer
  end
end
