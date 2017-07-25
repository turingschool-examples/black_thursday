require './lib/sales_engine'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class SalesEngineTest < Minitest::Test

  def test_class_takes_csv

  se = SalesEngine.new
  se.from_csv({:items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",})


  assert_equal se.from_csv[:items], "./data/items.csv"

  end
end
