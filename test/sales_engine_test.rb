require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.new
    assert_instance_of SalesEngine, se
  end

  def test_engine_attributes
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    assert_instance_of Array, SalesEngine.items
    assert_instance_of Array, SalesEngine.merchants
  end
end
