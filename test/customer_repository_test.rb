require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer_repository'
require 'time'
require 'pry'

class CustomerRepositoryTest < Minitest::Test
  def test_customer_repository_exists
    cr = CustomerRepository.new("./data/customers.csv")

    assert_instance_of CustomerRepository, cr
  end

  def test_all_returns_array_of_all_customers
    cr = CustomerRepository.new("./data/customers.csv")

    assert_instance_of Customer, cr.all[0]
    assert_equal 1000, cr.all.count
  end

  def test_it_can_find_a_customer_by_id
    cr = CustomerRepository.new("./data/customers.csv")

    assert_equal cr.all[99], cr.find_by_id(100)
    assert_nil cr.find_by_id(1500)
  end

  def test_it_can_find_a_customer_by_first_name
    cr = CustomerRepository.new("./data/customers.csv")

    assert_equal 8, cr.find_all_by_first_name("oe").count
    assert_equal 57, cr.find_all_by_first_name("NN").count
  end

  def test_it_can_find_a_customer_by_last_name
    cr = CustomerRepository.new("./data/customers.csv")

    assert_equal 85, cr.find_all_by_last_name("On").count
    assert_equal 85, cr.find_all_by_last_name("oN").count
  end

  def test_that_it_can_create_an_customer
    cr = CustomerRepository.new("./data/customers.csv")
    attributes = {
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    actual = cr.create(attributes).last
    expected = cr.find_by_id(1001)
    assert_equal expected, actual
  end

  def test_it_can_update_an_existing_customer
    cr = CustomerRepository.new("./data/customers.csv")
    attributes = {
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    cr.create(attributes)
    cr.update(1001, {last_name: "Smith"})
    updated_customer = cr.all.last
    assert_equal "Smith" , updated_customer.last_name
    cr.update(1001, {first_name: "John"})
    assert_equal "John" , updated_customer.first_name
    assert_nil cr.update(5000, {})
  end

  def test_it_cannot_update_ids_on_an_customer
    cr = CustomerRepository.new("./data/customers.csv")
    data = {
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    cr.create(data)
    attributes = ({
      id: 2000,
      created_at: Time.now
      })
    cr.update(1001, attributes)
    assert_equal nil, cr.find_by_id(2000)
    assert_equal cr.all[1000], cr.find_by_id(1001)
    updated_customer = cr.all.last
    created_at = cr.find_by_id(1001).created_at != attributes[:created_at]
    assert_equal true, created_at
  end

  def test_it_can_delete_an_customer
    cr = CustomerRepository.new("./data/customers.csv")
    data = {
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    cr.create(data)
    cr.delete(1001)
    assert_nil cr.find_by_id(1001)
    assert_nil cr.delete(2000)
  end
end
