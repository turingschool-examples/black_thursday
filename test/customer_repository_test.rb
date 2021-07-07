require_relative '../lib/customer_repository'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'
require_relative './test_helper'
require 'pry'

class CustomerRepositoryTest < Minitest::Test
  def test_it_exists
    c = CustomerRepository.new('./short_tests/short_customers.csv')

    assert_instance_of CustomerRepository, c
  end

  def test_it_can_find_names
    c = CustomerRepository.new('./short_tests/short_customers.csv')

    customer_1 = c.find_by_id(2)

    assert_equal "Cecelia", customer_1.first_name
    assert_equal "Osinski", customer_1.last_name
  end

  def test_it_can_create_new_customer
    c = CustomerRepository.new('./short_tests/short_customers.csv')

    attributes = ({
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
    })
    c.create(attributes)

    assert_equal 11, c.repo.last.id
  end

  def test_it_can_update_attributes
    c = CustomerRepository.new('./short_tests/short_customers.csv')

    customer_1 = c.find_by_id(2)
    c.update(2, {first_name: "Averi"})

    assert_equal "Averi", customer_1.first_name
  end
end
