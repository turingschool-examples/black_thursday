require './test/test_helper'
require './lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def test_it_exists
    cr = CustomerRepository.new('./data/customers_short.csv', self)

    assert_instance_of CustomerRepository, cr
  end

  def test_it_initializes_with_populated_array
    cr = CustomerRepository.new('./data/customers_short.csv', self)

    assert_equal 10, cr.customers.count
  end

  def test_it_can_return_all_customers
    cr = CustomerRepository.new('./data/customers_short.csv', self)

    target = cr.all

    assert_equal Array, target.class
    assert_equal 10, target.count
  end
end
