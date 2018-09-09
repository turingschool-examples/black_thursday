require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine.rb'

class SalesEngineTest <  Minitest::Test
  def test_it_exists
    se = SalesEngine.from_csv("./data/items_tiny.csv")
    actual = se.length
    expected = 19
    assert_equal expected, actual
  end

end
