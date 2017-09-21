require_relative 'test_helper'
require_relative '../lib/invoice_item'
require_relative '../lib/sales_engine'

class InvoiceItemTest < MiniTest::Test

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
    se.customers
    se.invoices
    se.merchants
    @iir = se.invoice_items
  end

  def test_can_be_connected_with_invoices
    invoice_item = @iir.find_by_id(547)

    assert_instance_of Invoice, invoice_item.invoices.first
    assert_equal 1, invoice_item.invoices.length
  end
end
