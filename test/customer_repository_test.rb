require_relative 'test_helper'
require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'

class CustomerRepositoryTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices => "./test/fixtures/invoices_fixture.csv",
      :customers => "./test/fixtures/customers_fixture.csv"
      })
    se.customers
  end

  def test_it_returns_customers
    cr = setup

    assert_instance_of Customer, cr.all.first
  end

  def test_it_finds_by_id
    cr = setup
    customer = cr.find_by_id(1)

    assert_equal 'Joey', customer.first_name
  end

  def test_it_can_find_customers_by_first_name
    cr = setup
    customers_1 = cr.find_all_by_first_name('Eileen')
    customers_2 = cr.find_all_by_first_name('Horace')

    assert_equal 18, customers_1.first.id
    assert customers_2.empty?
  end

  def test_it_can_find_customers_by_last_name
    cr = setup
    customers_1 = cr.find_all_by_last_name('Fadel')
    customers_2 = cr.find_all_by_last_name('Borgschutle')

    assert_equal 2, customers_1.count
    assert customers_2.empty?
  end

  def test_it_can_find_customers_by_name_with_a_fragment_and_case_insensitive
    cr = setup
    customers_1 = cr.find_all_by_first_name('e')
    customers_2 = cr.find_all_by_last_name('aD')

    assert_equal 15, customers_1.count
    assert_equal 4, customers_2.count
  end


end
