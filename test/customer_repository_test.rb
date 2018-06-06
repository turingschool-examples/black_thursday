# frozen_string_literal: false

require_relative 'test_helper'
require './lib/sales_engine'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(customers: './data/customers.csv')
    @customers = @se.customers
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @customers
  end

  def test_merchant_repo_holds_all_instances_of_customer
    assert_equal 1000, @customers.all.length
  end

  def test_all_returns_array_of_all_customer_objects
    customers = @customers.all
    assert customers.all? do |customer|
      customer.class == Customer
    end
  end

  def test_find_by_id_returns_customer_with_given_id
    refute @customers.find_by_id('notarealid')
    assert_instance_of Customer, @customers.find_by_id(20)
    assert_equal 20, @customers.find_by_id(20).id
    assert_equal 'Alessandra', @customers.find_by_id(20).first_name
    assert_equal 'Ward', @customers.find_by_id(20).last_name
  end

  def test_find_all_by_first_name_fragment
    assert_instance_of Array, @customers.find_all_by_first_name('mac')
    assert_equal 2, @customers.find_all_by_first_name('mac').length
    assert_equal [], @customers.find_all_by_first_name('asdgihweogdv')
  end

  def test_find_all_by_last_name_fragment
    assert_instance_of Array, @customers.find_all_by_last_name('man')
    assert_equal 35, @customers.find_all_by_last_name('man').length
    assert_equal [], @customers.find_all_by_last_name('asdgihweogdv')
  end

  def test_it_can_create_a_new_customer_object
    refute @customers.find_by_id(1001)
    attributes = { first_name: 'Homer', last_name: 'Simpson' }
    @customers.create(attributes)
    assert_equal 'Homer', @customers.find_by_id(1001).first_name
    assert_equal 1, @customers.find_all_by_last_name('simpson').length
  end

  def test_it_can_update_a_customer_first_name
    @customers.create(first_name: 'Margaret', last_name: 'Simpson')
    assert_equal 1, @customers.find_all_by_first_name('Margaret').length
    assert_equal 0, @customers.find_all_by_first_name('Marge').length

    @customers.update(1001, first_name: 'Marge', last_name: 'Simpson')
    assert_equal 0, @customers.find_all_by_first_name('Margaret').length
    assert_equal 1, @customers.find_all_by_first_name('Marge').length
  end

  def test_it_can_delete_a_customer_object
    assert @customers.find_by_id(1)
    @customers.delete(1)
    refute @customers.find_by_id(1)
  end
end
