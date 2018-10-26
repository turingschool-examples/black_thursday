
require './lib/sales_engine'
require './lib/fixturable'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'





class FixturableTest < Minitest::Test
  SalesAnalyst.include(Fixturable)
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
  # def test_it_can_run
  #   @sa.sample
  #   binding.pry
  # end
end
