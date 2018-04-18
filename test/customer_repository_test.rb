require 'time'
require 'csv'
require_relative 'test_helper'
require_relative '../lib/file_io'
require_relative '../lib/elementals/customer'
require_relative '../lib/repositories/customer_repository'

# Test for the CustomerRepository class
class CustomerRepositoryTest < Minitest::Test
  def setup
    csv = parse_data(customers)
    @c_repo = CustomerRepository.new(csv)
    @customer1 = @c_repo.customers[1]
    @customer2 = @c_repo.customers[2]
    @customer3 = @c_repo.customers[3]
    @customer4 = @c_repo.customers[4]
    @customer5 = @c_repo.customers[5]
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @c_repo
  end

  def test_creating_an_index_of_customers_from_data
    assert_equal ({ 1 => @customer1, 2 => @customer2,
                    3 => @customer3, 4 => @customer4,
                    5 => @customer5 }), @c_repo.customers
  end

  def test_all_returns_an_array_of_all_customer_instances
    result = @c_repo.all
    assert_equal [@customer1, @customer2,
                  @customer3, @customer4,
                  @customer5], result
  end

  def test_all_returns_correct_ids
    all_customers = @c_repo.all
    actual_all_ids = all_customers.map(&:id)
    expected = [1, 2, 3, 4, 5]
    assert_equal expected, actual_all_ids
  end

  def test_can_find_by_id
    assert_equal @customer1, @c_repo.find_by_id(1)
    assert_equal @customer2, @c_repo.find_by_id(2)
    assert_equal @customer3, @c_repo.find_by_id(3)
    assert_equal @customer4, @c_repo.find_by_id(4)
    assert_equal @customer5, @c_repo.find_by_id(5)
  end

  def test_can_find_all_by_first_name
    actual = @c_repo.find_all_by_first_name('Mariah')
    assert_equal [@customer3, @customer5], actual
  end

  def test_can_find_all_by_last_name
    actual = @c_repo.find_all_by_last_name('Ondricka')
    assert_equal [@customer1, @customer2], actual
  end

  def test_it_can_generate_next_customer_id
    assert_equal 6, @c_repo.create_new_id
  end

  def test_can_create_new_customer
    new_customer = @c_repo.create(
      first_name: 'Cole',
      last_name: 'Hart',
      created_at: '2009-12-09 12:08:04 UTC',
      updated_at: '2010-12-09 12:08:04 UTC'
    )
    assert_equal new_customer, @c_repo.customers[6]
  end

  def test_customer_can_be_updated
    @c_repo.update(5, first_name: 'Jude')
    assert_equal 'Jude', @c_repo.customers[5].first_name
    @c_repo.update(5, last_name: 'Dutton')
    assert_equal 'Dutton', @c_repo.customers[5].last_name
  end

  def test_customer_can_be_deleted
    @c_repo.delete(5)
    expected = { 1 => @customer1, 2 => @customer2,
                 3 => @customer3, 4 => @customer4 }
    assert_equal expected, @c_repo.customers
  end

  def test_custom_inspect_returns_correct_value
    assert_equal '#<CustomerRepository 5 rows>', @c_repo.inspect
  end

  def customers
    %(id,first_name,last_name,created_at,updated_at
     1,Joey,Ondricka,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC
     2,Cecelia,Ondricka,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
     3,Mariah,Toy,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
     4,Leanne,Braun,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC
     5,Mariah,Braun,2012-03-27 14:54:10 UTC,2012-03-27 14:54:10 UTC)
  end

  def parse_data(data)
    CSV.parse(data, headers: :true, header_converters: :symbol)
  end
end
