require_relative 'test_helper'
require_relative '../lib/customer_repository.rb'
require 'pry'

class CustomerRepositoryTest < Minitest::Test
  def setup
    customer_1 = Customer.new({
      id: 6,
      first_name: "Joan",
      last_name: "Clarke",
      created_at: "1972-07-30 18:08:53 UTC",
      updated_at: "2016-01-11 18:30:35 UTC"
      })
    customer_2 = Customer.new({
      id: 7,
      first_name: "Alan",
      last_name: "Turing",
      created_at: "1972-07-30 18:08:53 UTC",
      updated_at: "2016-01-11 18:30:35 UTC"
      })

    customers = [customer_1, customer_2]
    @customer_repository = CustomerRepository.new(customers)
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @customer_repository
  end

  def test_it_can_hold_customers
    assert_instance_of Array, @customer_repository.list
  end

  def test_its_holding_customers
    assert_instance_of Customer, @customer_repository.list[0]
    assert_instance_of Customer, @customer_repository.list[1]
  end

  def test_it_can_return_customers_using_all
    assert_instance_of Customer, @customer_repository.all[0]
    assert_instance_of Customer, @customer_repository.all[1]
  end

  def test_it_can_find_by_id
    expected = @customer_repository.list[0]
    actual = @customer_repository.find_by_id(6)
    assert_equal expected, actual
  end

  def test_it_can_find_all_by_first_name
    expected = 1
    actual = @customer_repository.find_all_by_first_name("Alan").count
    assert_equal expected, actual
    actual_2 = @customer_repository.find_all_by_first_name("ALAN").count
    assert_equal expected, actual_2
  end

  def test_it_can_find_all_by_last_name
    expected = 1
    actual = @customer_repository.find_all_by_last_name("Clarke").count
    assert_equal expected, actual
    actual_2 = @customer_repository.find_all_by_last_name("CLARKE").count
    assert_equal expected, actual_2
  end

  def test_it_create_new_customer_with_attributes
    new_customer_added = @customer_repository.create({
      first_name: "Pots",
      last_name: "McGee"
      })
    expected = @customer_repository.list[-1]
    actual = new_customer_added
    assert_equal expected, actual
  end

  def test_it_can_update_attributes
    @customer_repository.create({
      first_name: "Pots",
      last_name: "McGee"
      })
    new_customer = @customer_repository.list.last

    assert_equal "Pots", new_customer.first_name
    assert_equal "McGee", new_customer.last_name

    @customer_repository.update(8, {
      first_name: "Fats",
      last_name: "Lever"
      })
    changed_customer = @customer_repository.list.last

    assert_equal "Fats", changed_customer.first_name
    assert_equal "Lever", changed_customer.last_name

    assert_equal new_customer.id, changed_customer.id
  end
end
