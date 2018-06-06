require './test/test_helper'
require './lib/customer_repository'
require './lib/customer'
require 'csv'

class CustomerRepositoryTest < Minitest::Test
  def setup
    @customers = CSV.open './data/customer_test_data.csv',
                          headers: true,
                          header_converters: :symbol
    @customer_repository = CustomerRepository.new
  end

  def test_exists
    assert_instance_of CustomerRepository, @customer_repository
  end

  def test_all_defaults_empty
    assert_equal [], @customer_repository.all
  end

  def test_load_customers
    @customer_repository.load_customers(@customers)

    assert_equal 10, @customer_repository.all.length
    assert_instance_of Customer, @customer_repository.all[0]
  end

  def test_find_by_id
    @customer_repository.load_customers(@customers)
    actual = @customer_repository.find_by_id(1)
    assert_equal 'Joey', actual.first_name
  end

  def test_find_all_by_first_name
    @customer_repository.load_customers(@customers)

    assert_equal 2, @customer_repository.find_all_by_first_name('Joey').length
    assert_equal [], @customer_repository.find_all_by_first_name('Huey')
  end

  def test_find_all_by_last_name
    @customer_repository.load_customers(@customers)

    assert_equal 2, @customer_repository.find_all_by_last_name('Nader').length
    assert_equal [], @customer_repository.find_all_by_last_name('Zanti')
  end

  def test_create
    attributes = {
      id: 6,
      first_name: 'Joan',
      last_name: 'Clarke',
      created_at: Time.now,
      updated_at: Time.now
    }
    @customer_repository.load_customers(@customers)
    @customer_repository.create(attributes)

    assert_equal 11, @customer_repository.all.length
    assert_equal 11, @customer_repository.all[-1].id
  end

  def test_update
    @customer_repository.load_customers(@customers)

    attributes = {
      first_name: 'Homer',
      last_name: 'Simpson'
    }

    time_before = @customer_repository.all[-1].updated_at
    @customer_repository.update(10, attributes)
    time_after = @customer_repository.all[-1].updated_at

    assert_equal 'Homer', @customer_repository.all[-1].first_name
    assert_equal 'Simpson', @customer_repository.all[-1].last_name
    assert time_before < time_after
  end

  def test_delete
    @customer_repository.load_customers(@customers)

    @customer_repository.delete(4)

    assert_equal 9, @customer_repository.all.length
  end
end
