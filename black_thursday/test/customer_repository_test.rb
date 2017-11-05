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
    assert_equal "Ramona", repository.customers[9].first_name
    assert_equal "Reynolds", repository.customers[9].last_name
    assert_equal 13, repository.customers.count
    assert_nil repository.parent
  end

  def test_load_csv_can_load_file
    assert_instance_of CSV, repository.load_csv("./test/fixtures/truncated_customers.csv")
  end

  def test_all_returns_all_customers
    assert_equal 13, repository.all.count
    assert_instance_of Customer, repository.all.first
    assert_instance_of Customer, repository.all.last
  end

  def test_find_by_id
    assert_instance_of Customer, repository.find_by_id(2)
    assert_equal "Nader", repository.find_by_id(5).last_name
    assert_instance_of Time, repository.find_by_id(1).created_at
  end

  def test_find_by_id_edge_cases
    assert_nil repository.find_by_id(nil)
    assert_nil repository.find_by_id("words")
    assert_nil repository.find_by_id('721')
  end

  def test_find_all_by_first_name
    result = repository.find_all_by_first_name("Elva")
    assert_equal "Elva", result.first.first_name
    assert_equal "Elva", result.last.first_name
    assert_equal "Hermann", result.first.last_name
    assert_equal "Wiza", result.last.last_name
    assert_equal 30, result.first.id
    assert_equal 611, result.last.id
  end

  def test_find_all_by_first_name_edge_cases
    assert_equal [], repository.find_all_by_first_name(nil)
    # this breaks the program, and we don't have integer edge cases for other repos.
    # assert_equal [], repository.find_all_by_first_name(14214)
    assert_equal [], repository.find_all_by_first_name('fakename')
  end

  def test_find_all_by_last_name
    result = repository.find_all_by_last_name("Ondricka")
    assert_equal "Joey", result.first.first_name
    assert_equal "Danyka", result.last.first_name
    assert_equal "Ondricka", result.first.last_name
    assert_equal "Ondricka", result.last.last_name
    assert_equal 1, result.first.id
    assert_equal 764, result.last.id
  end

  def test_find_all_by_last_name_edge_cases
    # add integer edgecase
    assert_equal [], repository.find_all_by_last_name(nil)
    assert_equal [], repository.find_all_by_last_name('fakename')
  end

  def test_inspect
    assert_equal "CustomerRepository has 13 rows", repository.inspect
  end
end