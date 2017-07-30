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
end
