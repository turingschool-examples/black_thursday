require_relative './test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def test_it_exists
    cr = CustomerRepository.new('./test/data/customer_sample.csv')
    assert_instance_of CustomerRepository, cr
  end

  def test_customer_repo_has_repository_array_and_returns_all
    cr = CustomerRepository.new('./test/data/customer_sample.csv')
    assert_equal 10, cr.all.count
    assert_instance_of Array, cr.all
  end

  def test_it_can_find_customer_by_id
    cr = CustomerRepository.new('./test/data/customer_sample.csv')
    assert_instance_of Customer, cr.find_by_id(6)
  end

  def test_it_can_find_all_by_first_name
    cr = CustomerRepository.new('./test/data/customer_sample.csv')
    assert_equal "Joey", cr.find_all_by_first_name("Joey").first.first_name
    assert_instance_of Customer, cr.find_all_by_first_name("Joey").first
  end

  def test_it_can_find_all_by_last_name
    cr = CustomerRepository.new('./test/data/customer_sample.csv')
    assert_equal "Ondricka", cr.find_all_by_last_name("Ondricka").first.last_name
    assert_instance_of Customer, cr.find_all_by_last_name("Ondricka").first
  end

  def test_merchant_repo_can_create_a_merchant
    cr = CustomerRepository.new('./test/data/customer_sample.csv')
    new_customer = cr.create({:first_name => 'Duck'})
    assert_equal 'Duck', new_customer.first_name
    assert_equal 11, new_customer.id
  end

end
