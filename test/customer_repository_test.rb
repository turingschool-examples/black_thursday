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

end
