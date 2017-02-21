gem 'minitest'
require 'minitest/autorun'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_sales_engine_exists
    engine = SalesEngine.new
    assert engine
  end

  def test_sales_engine_can_read_file
    skip
    se = SalesEngine.new

    assert_equal ""
  end

end
