require_relative 'test_helper'
require './lib/customer_repository'
require 'pry'

class CustomerRepositoryTest < Minitest::Test
  def test_it_exists
    cr = CustomerRepository.new("./data/mini_customers.csv")
    assert_instance_of CustomerRepository, cr
  end

  def test_it_can_return_all_customers
    cr = CustomerRepository.new("./data/mini_customers.csv")
    assert_equal 2, cr.all.count
  end

  def test_it_can_find_by_id
    cr = CustomerRepository.new("./data/mini_customers.csv")
    assert_instance_of Customer, cr.find_by_id(1)
  end

  def test_it_can_find_all_by_first_name
    cr = CustomerRepository.new("./data/mini_customers.csv")
    assert_instance_of Array, cr.find_all_by_first_name("Joey")
  end

  def test_it_can_find_all_by_first_name_fragment
    cr = CustomerRepository.new("./data/mini_customers.csv")
    assert_instance_of Array, cr.find_all_by_first_name("Jo")
  end

  def test_it_can_find_all_by_last_name
    cr = CustomerRepository.new("./data/mini_customers.csv")
    assert_instance_of Array, cr.find_all_by_last_name("Ondricka")
  end

  def test_it_can_find_all_by_last_name_fragment
    cr = CustomerRepository.new("./data/mini_customers.csv")
    assert_instance_of Array, cr.find_all_by_first_name("Ond")
  end
end
