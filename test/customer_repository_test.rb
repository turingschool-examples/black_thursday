require_relative 'test_helper'
require_relative '../lib/customer_repository.rb'
require 'pry'

class CustomerRepositoryTest < Minitest::Test
  def setup
    @customer_repository = CustomerRepository.new("./data/customers.csv")
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @customer_repository
  end

  def test_it_can_hold_customers
    assert_instance_of Array, @customer_repository.customers
  end

  def test_its_holding_customers
    assert_instance_of Customer, @customer_repository.customers[0]
    assert_instance_of Customer, @customer_repository.customers[25]
  end

  def test_it_can_return_customers_using_all
    assert_instance_of Customer, @customer_repository.all[5]
    assert_instance_of Customer, @customer_repository.all[97]
  end

  def test_it_can_find_by_id
    expected = @customer_repository.customers[0]
    actual = @customer_repository.find_by_id(1)
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_first_name
    expected = 1
    actual = @customer_repository.find_all_by_first_name("Joey").count
    assert_equal expected, actual
    actual_2 = @customer_repository.find_all_by_first_name("JOEY").count
    assert_equal expected, actual_2
  end

  def test_it_can_find_all_by_last_name
    expected = 3
    actual = @customer_repository.find_all_by_last_name("Ondricka").count
    assert_equal expected, actual
    actual_2 = @customer_repository.find_all_by_last_name("ONDRICKA").count
    assert_equal expected, actual_2
  end

  def test_it_create_new_customer_with_attributes
    new_customer_added = @customer_repository.create({
      first_name: "Pots",
      last_name: "McGee"
      })
    expected = @customer_repository.customers[-1]
    actual = new_customer_added
    assert_equal expected, actual
  end

  def test_it_can_update_attributes
    @customer_repository.create({
      first_name: "Pots",
      last_name: "McGee"
      })
    new_customer = @customer_repository.customers.last

    assert_equal "Pots", new_customer.first_name
    assert_equal "McGee", new_customer.last_name

    @customer_repository.update(1001, {
      first_name: "Fats",
      last_name: "Lever"
      })
    changed_customer = @customer_repository.customers.last

    assert_equal "Fats", changed_customer.first_name
    assert_equal "Lever", changed_customer.last_name

    assert_equal new_customer.id, changed_customer.id
  end
end
