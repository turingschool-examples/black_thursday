require_relative 'test_helper'
require_relative "../lib/customer_repo"

class CustomerRepoTest < Minitest::Test

  def test_it_initializes
    assert_instance_of CustomerRepository, CustomerRepository.new(self, "./data/customers.csv")
  end

  def test_it_can_create_invoice_item_instances
    customer_repo = CustomerRepository.new(self, "./data/customers.csv")

    assert_instance_of Customer, customer_repo.customers.first
  end

  def test_it_can_reach_the_customers_instances_through_all
    customer_repo = CustomerRepository.new(self, "./data/customers.csv")

    assert_instance_of Customer, customer_repo.all.first
  end

  def test_it_can_find_customers_by_id
    customer_repo = CustomerRepository.new(self, "./data/customers.csv")
    results = customer_repo.find_by_id(245)

    assert_equal "Norris", results.first_name
  end

  def test_find_by_id_can_return_nil
    customer_repo = CustomerRepository.new(self, "./data/customers.csv")
    results = customer_repo.find_by_id(30000)

    assert_nil results
  end

  def test_it_can_find_all_by_first_name
    customer_repo = CustomerRepository.new(self, "./data/customers.csv")
    results = customer_repo.find_all_by_first_name("Rick")

    assert_equal 1, results.length
    assert_equal "Brekke", results.first.last_name
    assert_instance_of Array, results
    assert_instance_of Customer, results.first
  end

  def test_find_all_by_item_id_can_return_an_empty_array
    customer_repo = CustomerRepository.new(self, "./data/customers.csv")
    results = customer_repo.find_all_by_first_name(000000)

    assert_equal [], results
  end

  def test_it_can_find_all_by_last_name
    customer_repo = CustomerRepository.new(self, "./data/customers.csv")
    results = customer_repo.find_all_by_last_name("DuBuque")

    assert_equal 4, results.length
    assert_equal "Derrick", results.first.first_name
    assert_instance_of Array, results
    assert_instance_of Customer, results.first
  end

end
