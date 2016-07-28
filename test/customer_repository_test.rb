require './test/test_helper'
require './lib/sales_engine'

class CustomerRepositoryTest < Minitest::Test

  def test_all_stores_an_array
    se = SalesEngine.from_csv({ customers: "./data/customers_sample.csv" })
    cr = se.customers

    assert_equal true, cr.all.is_a?(Array)
  end

  def test_it_populates_the_correct_number_of_customers
    se = SalesEngine.from_csv({ customers: "./data/customers_sample.csv" })
    cr = se.customers

    assert_equal 100, cr.all.length
  end

  def test_that_it_can_find_a_customer_by_its_id
    se = SalesEngine.from_csv({ customers: "./data/customers_sample.csv" })
    cr = se.customers

    assert_equal "Cecelia", cr.find_by_id(2).first_name
  end

  def test_that_it_returns_nil_for_invalid_id
    se = SalesEngine.from_csv({ customers: "./data/customers_sample.csv" })
    cr = se.customers

    assert_equal nil, cr.find_by_id(919)
  end

  def test_that_find_all_by_first_name_returns_an_array
    se = SalesEngine.from_csv({ customers: "./data/customers_sample.csv" })
    cr = se.customers

    assert_equal [], cr.find_all_by_first_name("Cthulu")
  end

  def test_that_find_all_by_first_name_returns_an_array_of_proper_length
    se = SalesEngine.from_csv({ customers: "./data/customers_sample.csv" })
    cr = se.customers

    assert_equal 2, cr.find_all_by_first_name("Dem").length
  end

  def test_that_find_all_by_first_name_is_case_insensitive
    se = SalesEngine.from_csv({ customers: "./data/customers_sample.csv" })
    cr = se.customers

    assert_equal 2, cr.find_all_by_first_name("deM").length
  end

  def test_that_find_all_by_last_name_returns_an_array
    se = SalesEngine.from_csv({ customers: "./data/customers_sample.csv" })
    cr = se.customers

    assert_equal [], cr.find_all_by_last_name("Ftagn")
  end

  def test_that_find_all_by_last_name_returns_an_array_of_proper_length
    se = SalesEngine.from_csv({ customers: "./data/customers_sample.csv" })
    cr = se.customers

    assert_equal 4, cr.find_all_by_last_name("Wi").length
  end

  def test_that_find_all_by_last_name_is_case_insensitive
    se = SalesEngine.from_csv({ customers: "./data/customers_sample.csv" })
    cr = se.customers

    assert_equal 4, cr.find_all_by_last_name("wI").length
  end
  
end
