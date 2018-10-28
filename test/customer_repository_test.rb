require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer_repository'
require 'time'

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
    skip
    cr = CustomerRepository.new("./data/customers.csv")


  end

end

# all - returns an array of all known Customers instances
# find_by_id - returns either nil or an instance of Customer with a matching ID
# find_all_by_first_name - returns either [] or one or more matches which have a first name matching the substring fragment supplied
# find_all_by_last_name - returns either [] or one or more matches which have a last name matching the substring fragment supplied
# create(attributes) - create a new Customer instance with the provided attributes. The new Customer’s id should be the current highest Customer id plus 1.
# update(id, attribute) - update the Customer instance with the corresponding id with the provided attributes. Only the customer’s first_name and last_name can be updated. This method will also change the customer’s updated_at attribute to the current time.
# delete(id) - delete the Customer instance with the corresponding id
