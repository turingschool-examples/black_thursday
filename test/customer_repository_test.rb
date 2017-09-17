require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/customer_repository"
require './lib/customer'

class CustomerRepositoryTest < Minitest::Test

  attr_reader :customer_repository

  def setup
    item_csv = "./test/test_fixtures/customers_short.csv"
    @customer_repository = CustomerRepository.new('fake_customer', item_csv)
  end

  def test_customer_repository_exists
    assert_instance_of CustomerRepository, customer_repository
  end

  def test_all_makes_array_of_all_customers
    assert_instance_of Array, customer_repository.all
    assert_instance_of Customer, customer_repository.all[0]
  end

  def test_find_by_id_returns_nil_for_invalid_id
    assert_nil  customer_repository.find_by_id(1234)
  end

  def test_find_by_id_returns_item_instance_for_id
    assert_instance_of Customer, customer_repository.find_by_id(1)
  end

  def test_find_all_by_first_name
    assert_instance_of Array, customer_repository.find_all_by_first_name("Cecelia")
    assert_instance_of Customer, customer_repository.find_all_by_first_name("Cecelia")[0]
  end

  def test_find_all_by_last_name
    assert_instance_of Array, customer_repository.find_all_by_last_name("Osinski")
    assert_instance_of Customer, customer_repository.find_all_by_last_name("Osinski")[0]
  end

end
