require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  
  def setup
    @sales_engine = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
  end

  def test_it_exists
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_it_loads_from_csv
   assert_equal 475, @sales_engine.merchants.all.length
  end
  
end
