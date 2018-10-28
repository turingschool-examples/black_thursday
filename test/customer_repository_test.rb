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
    skip
    cr = CustomerRepository.new("./data/customers.csv")
    data = ({
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
    cr.create(data)
    cr.update(4986, {status: :success})
    updated_customer = cr.all.last
    assert_equal "success" , updated_customer.status
    assert_nil cr.update(5000, {})
  end

  def test_it_cannot_update_ids_on_an_customer
    skip
    cr = CustomerRepository.new("./data/customers.csv")
    data = ({
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
    cr.create(data)
    attributes = ({
      id: 5000,
      customer_id: 2,
      merchant_id: 3,
      created_at: Time.now
      })
    cr.update(4986, attributes)
    assert_equal nil, cr.find_by_id(5000)
    assert_equal cr.all[4985], cr.find_by_id(4986)
    updated_customer = cr.all.last
    assert_equal 7 , updated_customer.customer_id
    assert_equal 8 , updated_customer.merchant_id
    created_at = cr.find_by_id(4986).created_at != attributes[:created_at]
    assert_equal true, created_at
  end

  def test_it_can_delete_an_customer
    skip
    cr = CustomerRepository.new("./data/customers.csv")
    data = ({
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
    cr.create(data)
    cr.delete(4986)
    assert_nil cr.find_by_id(4986)
    assert_nil cr.delete(5000)
  end

end


# find_all_by_first_name - returns either [] or one or more matches which have a first name matching the substring fragment supplied
# find_all_by_last_name - returns either [] or one or more matches which have a last name matching the substring fragment supplied
# create(attributes) - create a new Customer instance with the provided attributes. The new Customer’s id should be the current highest Customer id plus 1.
# update(id, attribute) - update the Customer instance with the corresponding id with the provided attributes. Only the customer’s first_name and last_name can be updated. This method will also change the customer’s updated_at attribute to the current time.
# delete(id) - delete the Customer instance with the corresponding id
