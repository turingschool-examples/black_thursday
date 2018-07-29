require_relative '../lib/customer_repository'
require_relative '../lib/customer'
require_relative './test_helper'

class CustomerRepositoryTest < Minitest::Test
  def setup
    @customers =
      [{id: 1,
      first_name: 'Jane',
      last_name: 'Doe',
      created_at: '2010-12-10',
      updated_at: '2011-12-04'},
      {id: 2,
      first_name: 'John',
      last_name: 'Doe',
      created_at: '2009-05-30',
      updated_at: '2010-08-29'},
      {id: 3,
      first_name: 'Jerry',
      last_name: 'Doe',
      created_at: '2010-03-30',
      updated_at: '2013-01-21'},
      {id: 4,
      first_name: 'Jerry',
      last_name: 'Don',
      created_at: '2010-03-30',
      updated_at: '2013-01-21'}
    ]

    @customer_repository = CustomerRepository.new(@customers)
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @customer_repository
  end

  def test_it_can_build_customer
    assert_equal Array, @customer_repository.build_customer(@customers).class
  end

  def test_can_get_an_array_of_customers
    assert_equal 4, @customer_repository.all.count
  end

  def test_it_can_find_a_customer_by_a_valid_id
    customer = @customer_repository.find_by_id(2)
    assert_equal Customer, customer.class
    assert_equal 2, customer.id
  end

  def test_it_returns_nil_if_customer_id_is_invalid
    customer = @customer_repository.find_by_id('invalid')
    assert_nil customer
  end

  def test_it_can_find_a_customer_by_a_valid_first_name
    customer_1 = @customer_repository.find_all_by_first_name('Jane')
    assert_equal Customer, customer_1[0].class
    assert_equal 'Jane', customer_1[0].first_name

    customer_2 = @customer_repository.find_all_by_first_name('Jerry')
    assert_equal 2, customer_2.count
  end

  def test_it_returns_nil_if_customer_first_name_is_invalid
    customer = @customer_repository.find_all_by_first_name('invalid')
    assert_equal [], customer
  end

  def test_it_can_find_a_customer_by_a_valid_last_name
    customer_1 = @customer_repository.find_all_by_last_name('Don')
    assert_equal Customer, customer_1[0].class
    assert_equal 'Don', customer_1[0].last_name

    customer_2 = @customer_repository.find_all_by_last_name('Doe')
    assert_equal 3, customer_2.count
  end

  def test_it_returns_nil_if_customer_last_name_is_invalid
    customer = @customer_repository.find_all_by_last_name('invalid')
    assert_equal [], customer
  end

  def test_it_can_find_highest_id
    customer = @customer_repository.find_highest_id
    assert_equal 4, customer.id
  end

end
