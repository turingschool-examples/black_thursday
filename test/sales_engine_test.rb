require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.new

  def test_sales_engine_exists
    assert_instance_of SalesEngine, @se
  end
end
