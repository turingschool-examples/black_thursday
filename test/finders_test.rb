
require './lib/sales_engine'
require './lib/finders'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'


class FindersTest < Minitest::Test
  SalesAnalyst.include(Finders)
  def setup
    se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv',
      customers: './data/customers.csv'
    })
    @sa = se.analyst
  end
  def test_it_can_find_invoices_from_anything
    assert_instance_of Invoice, find_invoices_from(@sa.merchants[0])[0]
    assert_instance_of Invoice, find_invoices_from(@sa.items[0])[0]
    assert_instance_of Invoice, find_invoices_from(@sa.invoice_items[0])[0]
    assert_instance_of Invoice, find_invoices_from(@sa.transactions[0])[0]
    assert_instance_of Invoice, find_invoices_from(@sa.customers[0])[0]
  end
end
