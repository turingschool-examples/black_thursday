require_relative 'test_helper'
require_relative "../lib/customer_repo"

class CustomerRepoTest < Minitest::Test

  def test_it_initializes
    assert_instance_of CustomerRepository, CustomerRepository.new(self, "./data/customers.csv")
  end

  def test_it_can_create_invoice_item_instances
    skip
    customer_repo = CustomerRepository.new(self, "./data/customers.csv")

    assert_instance_of Transaction, customer_repo.customers.first
  end

  def test_it_can_reach_the_customers_instances_through_all
    skip
    customer_repo = CustomerRepository.new(self, "./data/customers.csv")

    assert_instance_of Transaction, customer_repo.all.first
  end

  def test_it_can_find_customers_by_id
    skip
    customer_repo = CustomerRepository.new(self, "./data/customers.csv")
    results = customer_repo.find_by_id(580)

    assert_equal 1504, results.invoice_id
  end

  def test_find_by_id_can_return_nil
    skip
    customer_repo = CustomerRepository.new(self, "./data/customers.csv")
    results = customer_repo.find_by_id(30000)

    assert_nil results
  end

  def test_it_can_find_all_by_invoice_id
    skip
    customer_repo = CustomerRepository.new(self, "./data/customers.csv")
    results = customer_repo.find_all_by_invoice_id(2880)

    assert_equal 2, results.length
    assert_instance_of Array, results
    assert_instance_of Transaction, results.first
  end

  def test_find_all_by_item_id_can_return_an_empty_array
    skip
    customer_repo = CustomerRepository.new(self, "./data/customers.csv")
    results = customer_repo.find_all_by_invoice_id(000000)

    assert_equal [], results
  end

  def test_it_can_find_all_by_credit_card_number
    skip
    customer_repo = CustomerRepository.new(self, "./data/customers.csv")
    results = customer_repo.find_all_by_credit_card_number(4613250127567219)

    assert_equal 1, results.length
    assert_instance_of Array, results
    assert_equal 7, results.first.id
  end

  def test_find_all_by_credit_card_number_can_return_an_empty_array
    skip
    customer_repo = CustomerRepository.new(self, "./data/customers.csv")
    results = customer_repo.find_all_by_credit_card_number(000000)

    assert_equal [], results
  end

  def test_it_can_find_all_by_result
    skip
    customer_repo = CustomerRepository.new(self, "./data/customers.csv")
    results = customer_repo.find_all_by_result("success")

    assert_equal 4158, results.length
    assert_instance_of Array, results
    assert_equal 1, results.first.id
  end

  def test_find_by_result_can_return_an_empty_Array
    skip
    customer_repo = CustomerRepository.new(self, "./data/customers.csv")
    results = customer_repo.find_all_by_result("dunno")

    assert_equal [], results
  end

end
