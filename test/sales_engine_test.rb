require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib.sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :se
  def setup
    @se = SalesEngine.from_csv({
    :items => "./test/fixtures/items.csv",
    :merchants => "./test/fixtures/merchants.csv",
    :invoices => "./test/fixtures/invoices.csv"
    })
  end
end
