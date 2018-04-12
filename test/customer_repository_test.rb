require 'time'
require_relative 'test_helper'
require_relative '../lib/fileio'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'

# Test for the CustomerRepository class
class CustomerRepositoryTest < Minitest::Test
  def setup
    file_path = FileIO.load('./test/fixtures/test_customers.csv')
    @c_repo = CustomerRepository.new(file_path)
    @new_customer = @c_repo.create(
      first_name: 'Cole',
      last_name: 'Hart',
      created_at: '2009-12-09 12:08:04 UTC',
      updated_at: '2010-12-09 12:08:04 UTC'
    )
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @c_repo
  end

  def test_creating_an_index_of_customers_from_data
    assert_instance_of Hash, @c_repo.customers
    assert_instance_of Customer, @c_repo.customers[1]
    assert_instance_of Customer, @c_repo.customers[2]
    assert_instance_of Customer, @c_repo.customers[3]
  end

  def test_all_returns_an_array_of_all_customer_instances
    assert_instance_of Array, @c_repo.all
  end

  def test_all_returns_correct_ids
    all_customers = @c_repo.all
    actual_all_ids = all_customers.map(&:id)
    expected = [1, 2, 3, 4, 5, 6]
    assert_equal expected, actual_all_ids
  end

  def test_can_find_by_id
    actual_one = @c_repo.find_by_id(1)
    actual_two = @c_repo.find_by_id(2)
    assert_instance_of Customer, actual_one
    assert_instance_of Customer, actual_two
    assert_equal 'Joey', actual_one.first_name
    assert_equal 'Cecelia', actual_two.first_name
  end

  def test_can_find_all_by_first_name
    actual = @c_repo.find_all_by_first_name('Mariah')
    result = actual.all? do |customer|
      customer.class == Customer
    end
    assert result
    ids = actual.map(&:id)
    assert_equal [3, 5], ids
  end

  def test_can_find_all_by_last_name
    actual = @c_repo.find_all_by_last_name('Ondricka')
    result = actual.all? do |customer|
      customer.class == Customer
    end
    assert result
    ids = actual.map(&:id)
    assert_equal [1, 2], ids
  end

  def test_it_can_generate_next_customer_id
    expected = 7
    actual = @c_repo.create_new_id
    assert_equal expected, actual
  end

  def test_can_create_new_customer
    assert_instance_of Customer, @new_customer
    assert_equal 6, @c_repo.customers.count
    assert_equal 'Cole', @c_repo.customers[6].first_name
    assert_equal 'Hart', @c_repo.customers[6].last_name
    assert_equal '2009-12-09 12:08:04 UTC', @c_repo.customers[6].created_at
    assert_equal '2010-12-09 12:08:04 UTC', @c_repo.customers[6].updated_at
  end

  def test_customer_can_be_updated
    @c_repo.update(6, first_name: 'Jude')
    assert_equal 'Jude', @c_repo.customers[6].first_name
    @c_repo.update(6, last_name: 'Dutton')
    assert_equal 'Dutton', @c_repo.customers[6].last_name
  end

  def test_customer_can_be_deleted
    @c_repo.delete(6)
    assert_equal 5, @c_repo.customers.count
    assert_nil @c_repo.customers[6]
  end
end
