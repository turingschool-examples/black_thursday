require_relative 'test_helper'
require_relative '../lib/transaction'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test
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
    se.merchants
    se.invoice_items
    se.customers
    se.invoices
    tr = se.transactions
  end

  # need to add basic tests

  def test_it_can_be_connected_with_an_invoice
    tr = setup

    transaction = tr.find_by_id(941)
require "pry"; binding.pry
    assert_instance_of Invoice, transaction.invoice
  end
end
