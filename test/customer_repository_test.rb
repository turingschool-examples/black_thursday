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

  def test_it_can_find_by_id
    cr = CustomerRepository.new('./data/customers_short.csv', self)

    target = cr.find_by_id(1)
    target_2 = cr.find_by_id(0)

    assert_equal "Joey", target.first_name
    assert_nil target_2
  end

  def test_it_can_find_by_first_name_fragment
    cr = CustomerRepository.new('./data/customers_short.csv', self)

    target = cr.find_all_by_first_name("Joey")
    target_2 = cr.find_all_by_first_name("joey")
    target_3 = cr.find_all_by_first_name("er")
    target_4 = cr.find_all_by_first_name("Hal")

    assert_equal "Joey", target[0].first_name
    assert_equal "Joey", target_2[0].first_name
    assert_equal 3, target_3.count
    assert_equal "Sylvester", target_3[0].first_name
    assert_equal [], target_4
  end
end
