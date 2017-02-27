require 'simplecov'
# SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'

require 'csv'
require 'bigdecimal'
require 'bigdecimal/util'
require './lib/sales_analyst'

class Minitest::Test
  attr_reader :engine

  def setup
    @engine ||= SalesEngine.from_csv({
              :items     => "./data/small_items.csv",
              :merchants => "./data/small_merchants.csv",
              :invoices => "./data/small_invoices.csv",
              :invoice_items => "./data/small_invoice_items.csv",
              :transactions => "./data/small_transactions.csv",
              :customers => "./data/small_customers.csv"
               })
    @analyst = SalesAnalyst.new(@engine)
  end
end
