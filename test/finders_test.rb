
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
  def test_it_can_find_invoice_from_anything
  end
end
