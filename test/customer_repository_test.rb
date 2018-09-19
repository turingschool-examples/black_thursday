require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def test_it_exits
    cr = CustomerRepository.new("./data/customers.csv")

    assert_instance_of CustomerRepository, cr
  end

  def test_it_initalizes_an_array_of_customer_objects
    cr = CustomerRepository.new("./data/customers.csv")

    assert_instance_of Customer, cr.objects_array[534]
    assert_equal 1000, cr.all.count
  end

  def test_it_finds_by_id
    cr = CustomerRepository.new("./data/customers.csv")
    customer = cr.find_by_id(798)

    assert_instance_of Customer, customer
    assert_equal 798, customer.id
  end

  def test_it_finds_all_by_first_name
    cr = CustomerRepository.new("./data/customers.csv")
    actual = cr.find_all_by_first_name('oe')

    assert_equal 8, actual.count
    assert_instance_of Customer, actual[4]
  end

  def test_it_finds_all_by_last_name
    cr = CustomerRepository.new("./data/customers.csv")
    actual = cr.find_all_by_last_name('On')

    assert_equal 85, actual.count
    assert_instance_of Customer, actual[4]
  end

  def test_create_creates_a_new_customer
    cr = CustomerRepository.new("./data/customers.csv")

    cr.create ({:first_name => "Harry",
                :last_name => "Potter",
                :created_at => Time.now,
                :updated_at => Time.now})

    new_customer = cr.all.last

    assert_equal 'Harry', new_customer.first_name
    assert_equal 'Potter', new_customer.last_name
    assert_instance_of Time, new_customer.created_at
    assert_instance_of Time, new_customer.updated_at
  end

  def test_that_update_updates_an_existing_customer
    cr = CustomerRepository.new("./data/customers.csv")
    old_customer = cr.find_by_id(1)
    assert_equal 'Joey', old_customer.first_name

    cr.update(1, {first_name: "Lily"})

    new_customer = cr.find_by_id(1)
    assert_equal "Lily", new_customer.first_name
  end

  def test_it_deletes_a_given_customer
    cr = CustomerRepository.new("./data/customers.csv")

    assert_instance_of Customer, cr.find_by_id(54)
    cr.delete(54)

    assert_nil cr.find_by_id(54)
  end

end
