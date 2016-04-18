require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_created_instance_of_sales_engine_class
    s = SalesEngine.new
    assert_equal SalesEngine, s.class
  end
end
