require_relative 'test_helper'
require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'

class CustomerRepositoryTest < Minitest::Test
  def setup
    files = ({:invoices => "./test/fixture/invoice_fixture.csv",
      :items => "./test/fixture/item_fixture.csv",
      :merchants => "./test/fixture/merchant_fixture.csv",
      :invoice_items => "./test/fixture/invoice_item_fixture.csv",
      :transactions => "./test/fixture/transaction_fixture.csv",
      :customers => "./test/fixture/customer_fixture.csv"})
    SalesEngine.from_csv(files).customers
  end

  def test_it_pulls_csv_info_from_customers_file
    assert_equal 19, setup.all.count
  end

  def test_it_returns_array_of_all_customers
    assert_equal 19, setup.all.count
    assert_instance_of Array, setup.all
  end

  def test_it_can_find_by_id
    assert_instance_of Customer, setup.find_by_id(9)

    customer_id = setup.find_by_id(9)

    assert_equal "Dejon", customer_id.first_name
  end

  def test_it_can_find_by_first_name
    customer_name = setup.find_all_by_first_name("He")

    assert_equal 2, customer_name.count
    assert_equal "Heber", customer_name[0].first_name
  end

  def test_it_can_find_by_last_name
    customer_name = setup.find_all_by_last_name("Nader")

    assert_equal 1, customer_name.count
    assert_equal "Nader", customer_name[0].last_name
  end
end
