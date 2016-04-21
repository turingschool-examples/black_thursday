require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require 'bigdecimal'
require './lib/sales_analysis'

class Minitest::Test
  def setup
    @engine = SalesEngine.from_csv({
  :items     => "./data/small_items.csv",
  :merchants => "./data/small_merchants.csv",
  })
  end
end
