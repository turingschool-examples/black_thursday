require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def setup
    @customer_repo = CustomerRepository.new('./test/fixtures/customers_sample.csv')
  end

  def test_if_it_exists
    assert_instance_of CustomerRepository, @customer_repo
  end

  def test_inspect_method
    assert_instance_of String, @customer_repo.inspect
  end

  def test_if_customers_repository_has_customers
    assert_instance_of Array, @customer_repo.all
    assert_equal 9, @customer_repo.all.count
    assert @customer_repo.all.all? { |customer| customer.is_a?(Customer)}
  end

  def test_if_it_can_load_correct_ids
    assert_equal 1, @customer_repo.all.first.id
    assert_equal 206, @customer_repo.all[7].id
  end

  def test_it_can_find_customer_by_id
    result = @customer_repo.find_by_id(206)

    assert_instance_of Customer, result
    assert_equal 206, result.id
    assert_equal "Oda", result.first_name
    assert_equal "Schinner", result.last_name
  end

  def test_it_can_find_another_customer_by_id
    result = @customer_repo.find_by_id(6)

    assert_instance_of Customer, result
    assert_equal 6, result.id
    assert_equal "Joey", result.first_name
    assert_equal "Ondricka", result.last_name
  end

  def test_it_can_return_nil_when_there_is_no_match_for_customer
    result = @customer_repo.find_by_id(32334388)

    assert_nil result
  end

  def test_it_can_find_all_customers_by_first_name
    result = @customer_repo.find_all_by_first_name("Joey")

    assert result.class == Array
    assert_equal 2, result.length
    assert_instance_of Customer, result.first
    assert_equal 1, result.first.id
    assert_equal 6, result.last.id
    assert_equal "Ondricka", result.last.last_name
  end

  def test_it_returns_empty_array_when_there_is_no_match_for_first_name
    result = @customer_repo.find_all_by_first_name("Mike")

    assert_equal [], result
  end

  def test_it_can_find_all_customers_by_last_name
    result = @customer_repo.find_all_by_last_name("Ondricka")

    assert result.class == Array
    assert_equal 2, result.length
    assert_instance_of Customer, result.first
    assert_equal 1, result.first.id
    assert_equal 6, result.last.id
    assert_equal "Joey", result.last.first_name
  end

  def test_it_returns_empty_array_when_there_is_no_match_for_last_name
    result = @customer_repo.find_all_by_last_name("Mike")

    assert_equal [], result
  end

end
