require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice'
require_relative '../lib/merchant'
require "time"


class InvoiceTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items => './test/fixtures/items_fixture.csv',
      :merchants => './test/fixtures/merchants.csv',
      :invoices => './test/fixtures/invoices.csv',
      :invoice_items => './test/fixtures/invoice_items.csv',
      :transactions => './test/fixtures/transactions.csv',
      :customers => './test/fixtures/customers.csv'})
    @invoices = @sales_engine.invoices
    @merchants = @sales_engine.merchants
  end

  def test_it_knows_where_it_came_from
    invoice = @invoices.invoices.first

    assert_equal @invoices, invoice.repository
  end

  def test_it_has_attributes
    invoice = @invoices.find_by_id(1)

    assert_equal 1, invoice.id
    assert_equal 1, invoice.customer_id
    assert_equal 12334112, invoice.merchant_id
    assert_equal :pending, invoice.status
    assert_equal Time.parse("2009-02-07"), invoice.created_at
    assert_equal Time.parse("2014-03-15"), invoice.updated_at
  end

  def test_it_can_find_a_merchant
    invoice = @invoices.find_by_id(1)
    merchant = @merchants.all[0]

    assert_instance_of Merchant, merchant
    assert_equal merchant, invoice.merchant
  end

end
