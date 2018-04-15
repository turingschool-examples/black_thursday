require 'time'
require 'csv'
require_relative 'test_helper'
require_relative '../lib/fileio'
require_relative '../lib/customer'
require_relative '../lib/customer_repository'

# Test for the CustomerRepository class
class CustomerRepositoryTest < Minitest::Test
  def setup
    data = %(id,first_name,last_name,created_at,updated_at
             1,Joey,Ondricka,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
             2,Cecelia,Ondricka,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
             3,Mariah,Toy,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
             4,Leanne,Braun,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
             5,Mariah,Braun,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC)
    # @customer_1 = Customer.new()
    # file_path = FileIO.load('./test/fixtures/test_customers.csv')
    csv = CSV.parse(data, {headers: true, header_converters: :symbol})
    @c_repo = CustomerRepository.new(csv)
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
    assert_equal 6, @c_repo.all.length
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
    assert_equal @new_customer, @c_repo.customers[6]
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
