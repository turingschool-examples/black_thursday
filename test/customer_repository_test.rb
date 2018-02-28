require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/customer_repository'
require_relative './master_hash'

class CustomerRepositoryTest < Minitest::Test
  def setup
    test_engine = TestEngine.new.god_hash
    sales_engine = SalesEngine.new(test_engine)
    @customer_repository = sales_engine.customers
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @customer_repository
  end

  def test_customer_repository_can_hold_items
    assert_equal 50, @customer_repository.all.count
    assert (@customer_repository.all.all? { |customer| customer.is_a?(Customer)})
  end

  def test_it_can_find_customer_by_id
    result = @customer_repository.find_by_id(8)

    result_nil = @customer_repository.find_by_id(1_989)

    assert_instance_of Customer, result
    assert_equal 8, result.id
    assert_nil result_nil
  end

  def test_it_can_find_all_customers_by_first_name
    result = @customer_repository.find_all_by_first_name('Mariah')

    result2 = @customer_repository.find_all_by_first_name('Megan')

    assert_equal 1, result.length
    assert_equal 'Mariah', result[0].first_name
    assert_instance_of Customer, result[0]
    assert_equal [], result2
  end

  def test_it_can_find_all_customers_by_last_name
    result = @customer_repository.find_all_by_last_name('Toy')

    result_nil = @customer_repository.find_all_by_last_name('Arellano')

    assert_equal 1, result.length
    assert_instance_of Customer, result[0]
    assert_equal [], result_nil
  end

  def test_customer_repo_finds_merchants_via_engine
    cr = @customer_repository
    result = cr.customer_repo_finds_merchants_via_engine(1)

    assert_equal 7, result.length
    assert_instance_of Merchant, result[0]
  end

  def test_inspect
    assert_equal "#<CustomerRepository 50 rows>", @customer_repository.inspect
  end
end
