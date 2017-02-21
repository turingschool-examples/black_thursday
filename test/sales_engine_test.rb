require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'


class SalesEngineTest < Minitest::Test

  def test_from_csv
    file = "./data/items.csv"
    se = SalesEngine.from_csv(file)
    assert_equal ({ :items => "./data/items.csv" }) , se

  end





end
