require_relative 'test_helper'
require_relative '../lib/customer_repo'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :customer_repo

  def set_up
    files = ({:customer => "./test/fixtures/customer_fixture.csv"})
    SalesEngine.from_csv(files).customers
  end

  def test_customer_exists
    assert_instance_of CustomerRepository, set_up
  end

  def test_all_customers
    assert_equal 9, set_up.all.count
  end

  def test_find_by_id_nil
    assert_nil set_up.find_by_id(39472)
  end

  def test_find_specific_id
    assert_instance_of Customer, set_up.find_by_id(8)
  end

  def test_find_specific_name
    assert_instance_of Customer, set_up.find_by_first_name("Heber")
  end
end
