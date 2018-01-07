require "./test/test_helper"
require "./lib/customer_repository"

class CustomerRepositoryTest < MiniTest::Test

  def setup
    @customers = CustomerRepository.new("./test/fixtures/customers_fixtures.csv")
  end

  def test_all_returns_customers
    assert_equal @customers.customers.values, @customers.all
  end

  def test_find_by_id_is_nil_when_passed_non_matching_id
    assert_nil @customers.find_by_id(13)
  end

  def test_find_by_id_returns_instance_of_customer
    assert_instance_of Customer, @customers.find_by_id(732)

    assert_equal 732, @customers.find_by_id(732).id
  end

  def test_find_all_by_first_name_returns_array
    assert_instance_of Array, @customers.find_all_by_first_name("Jermey")

    assert_equal "Jermey", @customers.find_all_by_first_name("Jermey").first.first_name
  end

  def test_find_all_by_first_name_returns_empty_array_when_none_found
    assert_equal [], @customers.find_all_by_first_name("Harry")
  end

  def test_find_all_by_last_name_returns_array
    assert_instance_of Array, @customers.find_all_by_last_name("Quigley")

    assert_equal "Quigley", @customers.find_all_by_last_name("Quigley").first.last_name
  end


  def test_find_all_by_last_name_returns_empty_array_when_none_found
    assert_equal [], @customers.find_all_by_last_name("Potter")
  end


  def test_inspect_returns_correct_string
    assert_equal "#<CustomerRepository 4 rows>", @customers.inspect
  end
end
