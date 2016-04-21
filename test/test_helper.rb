require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require 'bigdecimal'
require './lib/sales_analysis'

class Minitest::Test
  attr_reader :engine
              :analysis
  def setup
    @engine = SalesEngine.from_csv({
              :items     => "./data/small_items.csv",
              :merchants => "./data/small_merchants.csv",
               })
    @analysis = SalesAnalysis.new(@engine)
  end
end
