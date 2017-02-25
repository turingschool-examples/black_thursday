require './test/test_helper'
require './lib/sales_engine'
require './lib/customer_repository'
require './lib/customer'

class CustomerRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :customers => "./data/customers.csv"
      })

    @cr = @se.customers
  end

  def test_it_can_load_csv
    assert_instance_of CSV, @cr.csv
  end

  def test_it_can_create_instance_of_customer
    assert_instance_of Customer, @cr.all.first
  end

  def test_all_returns_an_array
    assert_instance_of Array, @cr.all
  end

  def test_all_contains_proper_number_of_customers
    assert_equal 1000, @cr.all.count
    assert_equal Customer, @cr.all.first.class
  end

  def test_it_can_find_a_customer_by_id
    customer = @cr.find_by_id(1)
    assert_instance_of Customer, customer
  end

  def test_it_can_find_all_customers_matching_first_name_fragment
    customers = @cr.find_all_by_first_name("Joey")
    assert_instance_of Customer, customers.first
  end

  def test_find_all_by_first_name_returns_an_array
    customers = @cr.find_all_by_first_name("a")
    assert_instance_of Array, customers
  end

  def test_it_can_find_all_by_last_name_fragment
    customers = @cr.find_all_by_last_name("Toy")
    assert_instance_of Customer, customers.first
  end

  def test_find_all_by_last_name_returns_an_array
    customers = @cr.find_all_by_last_name("b")
    assert_instance_of Array, customers
  end

end
