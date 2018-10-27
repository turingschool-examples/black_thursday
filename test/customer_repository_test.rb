require_relative './test_helper'

class CustomerRepositoryTest < Minitest::Test

  def test_it_exists
    cr = CustomerRepository.new('./test/data/customer_sample.csv')
    assert_instance_of CustomerRepository, cr
  end

  def test_customer_repo_has_repository_array_and_returns_all
    cr = CustomerRepository.new('./test/data/customer_sample.csv')
    assert_equal 25, cr.all.count
    assert_instance_of Array, cr.all
  end

  def test_it_can_find_customer_by_id
    cr = CustomerRepository.new('./test/data/customer_sample.csv')
    assert_instance_of Customer, cr.find_by_id("6")
  end

end
