require_relative 'test_helper'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class CustomerTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
    :items     => "./test/fixtures/items_fixture.csv",
    :merchants => "./test/fixtures/merchants_fixture.csv",
    :invoices => "./test/fixtures/invoices_fixture.csv",
    :transactions => "./test/fixtures/transactions_fixture.csv",
    :invoice_items => './test/fixtures/invoice_items_fixture.csv',
    :customers => "./test/fixtures/customers_fixture.csv"
    })
    se.items
    se.transactions
    se.invoice_items
    se.invoices
    se.merchants
    se.customers
  end

  def test_customer_exists
    cr = setup
    assert_instance_of Customer, cr.customers[0]
  end

  def test_it_returns_customer_attributes
    cr = setup
    assert_equal 1, cr.all.first.id
    assert_equal 'Joey', cr.all.first.first_name
    assert_equal 'Ondricka', cr.all.first.last_name
    assert_instance_of Time, cr.all.first.created_at
    assert_instance_of Time, cr.all.first.updated_at
  end

  def test_it_can_connect_with_invoices
    cr = setup

    customer = cr.find_by_id(1)
    assert_instance_of Invoice, customer.invoices[0]
  end

end
