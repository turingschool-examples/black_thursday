require_relative 'test_helper'
require_relative  '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  
  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.new
  end

  def test_it_can_merchants_from_small_file
    sales_engine.from_file({:items => 'small_items', :merchants => 'small_merchants'})
    assert_equal 5, sales_engine.merchants.all.count
  end

end