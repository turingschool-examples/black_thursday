require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < MiniTest::Test

  def test_it_exists
    se = SalesEngine.from_csv({
          :items     => "./data/items_fixture.csv",
          :merchants => "./data/merchants_fixture.csv",
        })
    mr = se.merchants
    ir = se.items
        
    assert ir
    assert mr
  end


end
