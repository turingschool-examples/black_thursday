require_relative 'test_helper'
require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'
require_relative './master_hash'

class CustomerRepositoryTest < Minitest::Test
  def setup
    test_engine = TestEngine.new.god_hash
    sales_engine = SalesEngine.new(test_engine)
    @customer_repository = sales_engine.invoices
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @customer_repository
  end

  def test_customer_repository_holds_all_customers
    assert_equal 50, @customer_repository.all.length
    assert (@customer_repository.all.all? { |invoice| invoice.is_a?(Invoice)})
  end

  def test_customer_repository_holds_customer_attributes
    customer_repository = @customer_repository

    assert_equal 1, customer_repository.all.first.id
    assert_equal "Joey", customer_repository.all.first.first_name
  end

  def test_it_can_find_all_customers_by_first_name
    customer_repository = @customer_repository

    result = customer_repository.find_all_by_first_name("Loyal")

    result_nil = customer_repository.find_all_by_customer_id("Megan")

    assert_instance_of Array, result
    assert result.length == 1
    assert_equal "Loyal", result[1].first_name

    assert result_nil.empty?
  end


  def test_it_can_find_all_customers_by_last_name
    customer_repository = @customer_repository

    result = customer_repository.find_all_by_last_name("Braun")

    result_nil = customer_repository.find_all_by_last_name("Arellano")

    assert_instance_of Array, result
    assert result.length == 1
    assert result_nil.empty?
  end
end
