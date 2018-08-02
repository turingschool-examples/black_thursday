require './test/test_helper'
require 'csv'
require_relative '../lib/sales_engine'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def setup
    @se= SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv",
      :invoices  => "./data/dummy_invoices.csv",
      :invoice_items => "./data/dummy_invoice_items.csv",
      :transactions =>"./data/dummy_transactions.csv",
      :customers => "./data/dummy_customers.csv" })
      @customer_repo = CustomerRepository.new(@se.csv_hash[:customers])
      @customer_repo.create_customers
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @customer_repo
  end

  def test_all
    assert_equal 10, @customer_repo.all.count
    assert_equal Customer, @customer_repo.all[0].class
  end

  def test_find_by_id
    customer = @customer_repo.find_by_id(10)
    assert_equal 10, customer.id
    customer = @customer_repo.find_by_id(376)
    assert_nil customer
  end

  def test_find_all_by_first_name
    assert_equal 2, @customer_repo.find_all_by_first_name("on").count
    assert_equal Customer, @customer_repo.find_all_by_first_name("on")[0].class
  end

  def test_find_all_by_last_name
    assert_equal 5, @customer_repo.find_all_by_last_name("a").count
    assert_equal Customer, @customer_repo.find_all_by_last_name("a")[0].class
  end

  def test_you_can_create_new_id
    expected = @customer_repo.create_id
    assert_equal 11, expected
  end

  def test_you_can_create
    attributes = {  first_name: "Harry",
                    last_name: "Potter",
                    created_at: '2018-07-31',
                    updated_at: '2018-07-31'
                  }
    expected = @customer_repo.create(attributes)
    assert_equal 11, expected.id
    assert_equal "Harry", expected.first_name
    assert_equal "Potter", expected.last_name
    assert_instance_of Time , expected.created_at
    assert_instance_of Time, expected.updated_at
  end

  def test_you_can_update
    attributes = {
     first_name: 'Sirius',
     last_name: 'Black' }
     @customer_repo.update(10, attributes)
     expected = @customer_repo.find_by_id(10)
     assert_instance_of Time, expected.updated_at
     assert_equal 'Sirius', expected.first_name
     assert_equal 'Black', expected.last_name
     assert_equal 10, expected.id
  end

  def test_you_can_delete
    @customer_repo.delete(2)
    assert_nil @customer_repo.find_by_id(2)
  end
end
