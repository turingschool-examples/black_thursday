require_relative 'test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_sales_engine_class_exists
    sales_engine = SalesEngine.new
    assert_instance_of SalesEngine, sales_engine
  end
end
