require_relative 'test_helper'
require 'csv'
require_relative './../lib/customer'
require_relative './../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :repository

  def setup
    @repository = CustomerRepository.new('./test/fixtures/truncated_customers.csv')
  end

  def test_it_exists
    assert_instance_of CustomerRepository, repository
  end

  def test_it_has_correct_attributes
    assert_equal Customer, repository.customers.first.class
    assert_equal Array, repository.customers.class
    assert_equal "Ramona", repository.customers.last.first_name
    assert_equal "Reynolds", repository.customers.last.last_name
    assert_equal 10, repository.customers.count
    assert_nil repository.parent
  end

  def test_load_csv_can_load_file
    assert_instance_of CSV, repository.load_csv("./test/fixtures/truncated_customers.csv")
  end

  def test_all_returns_all_customers
    assert_equal 10, repository.all.count
    assert_instance_of Customer, repository.all.first
    assert_instance_of Customer, repository.all.last
  end

  def test_find_by_id
    assert_instance_of Customer, repository.find_by_id(2)
    assert_equal "Nader", repository.find_by_id(5).last_name
    assert_instance_of Time, repository.find_by_id(1).created_at
  end
end