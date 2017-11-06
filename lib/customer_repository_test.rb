require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def test_it_pulls_csv_info_from_customers_file
    cr = CustomerRepository.new("./data/customers.csv")

    assert_equal 1000, cr.all.count
  end

  def test_it_returns_array_of_all_customers
    cr = CustomerRepository.new("./data/customers.csv")

    assert_equal 1000, cr.all.count
    assert_instance_of Array, cr.all
  end

  def test_it_can_find_by_id
    cr = CustomerRepository.new("./data/customers.csv")

    assert_instance_of Customer, cr.find_by_id(9)

    customer_id = cr.find_by_id(9)

    assert_equal "Dejon", customer_id.first_name
  end

  def test_it_can_find_by_first_name
    cr = CustomerRepository.new("./data/customers.csv")

    customer_name = cr.find_all_by_first_name("Mer")

    assert_equal 8, customer_name.count
    assert_equal "Elmer", customer_name[3].first_name
  end

  def test_it_can_find_by_last_name
    cr = CustomerRepository.new("./data/customers.csv")

    customer_name = cr.find_all_by_last_name("Smith")

    assert_equal 3, customer_name.count
    assert_equal "Smith", customer_name[2].last_name
  end
end
