require_relative 'test_helper'
require './lib/sales_engine'
require 'csv'

class CustomerRepositoryTest < Minitest::Test

  def setup
    item_file_path = './test/fixtures/items_truncated.csv'
    merchant_file_path = './test/fixtures/merchants_truncated.csv'
    invoice_file_path = './test/fixtures/invoices_truncated.csv'
    customer_file_path = './test/fixtures/customers_truncated.csv'
    transaction_file_path = './test/fixtures/transactions_truncated.csv'
    engine = SalesEngine.new(item_file_path, merchant_file_path, invoice_file_path, customer_file_path, transaction_file_path)
    @repository = engine.customers
    @customers = engine.customer_list
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @repository
  end

  def test_it_creates_invoice_objects_for_each_row
    assert_instance_of Customer, @customers[0]
  end

  def test_all_returns_array_of_all_customer_objects
    assert_equal 26, @customers.count
  end

  def test_find_by_id_returns_empty_if_no_match
    assert_empty(@repository.find_by_id(0))
  end

  def test_find_by_id_returns_customer_with_matching_id
    customer = @repository.find_by_id(something_valid)
    assert_instance_of Customer, customer
    assert_equal 'some name', customer.first_name
  end

  def test_find_all_by_first_name_returns_empty_if_no_match
    assert_empty(@repository.find_all_by_first_name('xyz'))
  end

  def test_it_finds_all_customers_with_matching_first_name_substring
    customers = @repository.find_all_by_first_name('something valid')

    assert_equal 1, customers.count

    customers = @repository.find_all_by_first_name('valid substring')

    assert_equal 1, customers.count

    customers = @repository.find_all_by_first_name('something weirdly capitalized')

    assert_equal 1, customers.count
  end

  def test_find_all_by_last_name_returns_empty_if_no_match
    assert_empty(@repository.find_all_by_last_name('xyz'))
  end

  def test_it_finds_all_customers_with_matching_last_name_substring
    customers = @repository.find_all_by_last_name('something valid')

    assert_equal 1, customers.count

    customers = @repository.find_all_by_last_name('valid substring')

    assert_equal 1, customers.count

    customers = @repository.find_all_by_last_name('something weirdly capitalized')

    assert_equal 1, customers.count
  end



end
