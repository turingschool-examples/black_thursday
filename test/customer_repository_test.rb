require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/customer_repository'
require 'pry'

class CustomerRepositoryTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items => './test/fixtures/items_fixture.csv',
      :merchants => './test/fixtures/merchants.csv',
      :invoices => './test/fixtures/invoices.csv',
      :invoice_items => './test/fixtures/invoice_items.csv',
      :transactions => './test/fixtures/transactions.csv',
      :customers => './test/fixtures/customers.csv'})
    @customers = @sales_engine.customers
    @merchants = @sales_engine.merchants
  end

  def test_that_it_finds_all_customers
    assert_equal @customers.customers, @customers.all
  end

  def test_that_it_finds_by_customer_id
    customer = @customers.all[2]

    assert_equal customer, @customers.find_by_id(3)
  end

  def test_that_it_finds_all_customers_by_first_name
    customer_1 = @customers.all[0]
    customer_2 = @customers.all[9]

    assert_equal [customer_1, customer_2], @customers.find_all_by_first_name("jOeY")
  end

  def test_that_it_finds_all_customers_by_last_name
    customer_1 = @customers.all[3]
    customer_2 = @customers.all[10]

    assert_equal [customer_1, customer_2], @customers.find_all_by_last_name("bRaUn")
  end

  def test_that_it_finds_all_merchants_by_customer_id
    merchant_1 = @merchants.all[0]
    merchant_2 = @merchants.all[3]

    assert_equal [merchant_1, merchant_2], @customers.find_merchants_by_customer_id(1)
  end

end
