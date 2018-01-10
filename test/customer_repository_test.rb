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
      :customers => './test/fixtures/customers.csv'})
    @customers = @sales_engine.customers
  end

  def test_that_it_finds_all_customers
    assert_equal @customers.customers, @customers.all
  end

end
