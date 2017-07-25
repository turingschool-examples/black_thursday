require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer_repo'

class CustomerRepositoryTest < Minitest::Test

  def test_it_exist
    customer_repo = CustomerRepository.new

    assert_instance_of CustomerRepository, customer_repo
  end

  def test_returns_an_array_of_known_customer_instances
    customer_repo = CustomerRepository.new

    assert_equal [], customer_repo.all
  end

  def test_can_find_by_id
    customer_repo = CustomerRepository.new

    assert_nil customer_repo.find_by_id("z32")
    assert_instance_of Customer, customer_repo.find_by_id("1")
  end

  def test_can_find_by_first_name
    customer_repo = CustomerRepository.new


    assert_equal [], customer_repo.find_all_by_first_name("Jo")
    assert_instance_of Customer, customer_repo.find_all_by_first_name("Jo")
  end

  def test_can_find_by_last_name
    customer_repo = CustomerRepository.new


    assert_equal [], customer_repo.find_all_by_last_name("Em")
    assert_instance_of Customer, customer_repo.find_all_by_last_name("Em")
  end

end
