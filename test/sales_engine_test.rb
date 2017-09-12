require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < MiniTest::Test

  def test_it_exists
    se = SalesEngine.new
    se.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
        })
    mr = se.merchants
    ir = se.items

    assert ir
    assert mr
  end

end
