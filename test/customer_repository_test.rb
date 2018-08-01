require 'simplecov'
SimpleCov.start
require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'

class CustomerRepositoryTest < Minitest::Test

  def setup
    @customer_repository = CustomerRepository.new
    @customer_repository.create_with_id({id: 1,
                                         first_name: "Dylan",
                                         last_name: "Meskis",
                                         created_at: "2010-10-31",
                                         updated_at: "2010-10-31"
                                         })
    @customer_repository.create_with_id({id: 2,
                                         first_name: "Patrick",
                                         last_name: "Shobe",
                                         created_at: "2010-10-31",
                                         updated_at: "2010-10-31"
                                         })
    @customer_repository.create_with_id({id: 3,
                                         first_name: "Sal",
                                         last_name: "Espinosa",
                                         created_at: "2010-10-31",
                                         updated_at: "2010-10-31"
                                         })
    @customer_repository.create_with_id({id: 4,
                                         first_name: "Salazar",
                                         last_name: "Shobenstein",
                                         created_at: "2010-10-31",
                                         updated_at: "2010-10-31"
                                         })
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @customer_repository
  end

  def test_it_starts_with_no_customers
    customer_repository = CustomerRepository.new
    assert_equal customer_repository.all, []
  end

  def test_we_can_find_all_by_first_name
    cust_1 = @customer_repository.all[1]
    cust_2 = @customer_repository.all[3]
    expected = [cust_1, cust_2]
    result = @customer_repository.find_all_by_last_name("Shobe")
    assert_equal expected, result
  end

  def test_we_can_find_all_by_last_name
    cust_1 = @customer_repository.all[2]
    cust_2 = @customer_repository.all[3]
    expected = [cust_1, cust_2]
    result = @customer_repository.find_all_by_first_name("Sal")
    assert_equal expected, result
  end

  def test_we_can_update
    @customer_repository.update(1, {first_name: "Bob", last_name: "Ross"})
    customer = @customer_repository.find_by_id(1)
    assert_equal "Bob", customer.first_name
    assert_equal "Ross", customer.last_name
  end

end
