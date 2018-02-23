require_relative 'test_helper'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'
require 'pry'

class CustomerRepositoryTest < Minitest::Test
  def setup
    @customer_repo = CustomerRepository.new('./test/fixtures/customers.csv')
  end

  def test_class_can_be_instantiated
    assert_instance_of CustomerRepository, @customer_repo
  end

  def test_class_can_load_customers_and_display_them
    assert_equal 5, @customer_repo.all.count
    assert_instance_of Customer, @customer_repo.all.first
  end

  def test_class_can_find_by_id
    assert_nil @customer_repo.find_by_id(80_000)
    assert_equal 1, @customer_repo.find_by_id(1).id
  end

  def test_can_find_by_first_name
    assert_equal [], @customer_repo.find_all_by_first_name('Alex')
    assert_equal 1, @customer_repo.find_all_by_first_name('Joey').count
  end

  def test_can_find_by_last_name
    assert_equal [], @customer_repo.find_all_by_last_name('Cutschall')
    assert_equal 1, @customer_repo.find_all_by_last_name('Ondricka').count
  end
end
