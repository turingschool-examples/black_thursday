require_relative 'test_helper'
require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'
require 'pry'
require 'time'

class CustomerTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items => './test/fixtures/items_fixture.csv',
      :merchants => './test/fixtures/merchants.csv',
      :invoices => './test/fixtures/invoices.csv',
      :invoice_items => './test/fixtures/invoice_items.csv',
      :transactions => './test/fixtures/transactions.csv',
      :customers => './test/fixtures/customers.csv'})
    @customers = @sales_engine.customers
  end

  def test_it_has_attributes
    customer1 = @customers.all[0]

    assert_equal 1, customer1.id
    assert_equal "Joey", customer1.first_name
    assert_equal "Ondricka", customer1.last_name
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), customer1.created_at
    assert_equal Time.parse("2012-03-27 14:54:09 UTC"), customer1.updated_at
  end

end
