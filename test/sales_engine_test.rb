require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    engine = SalesEngine.new

    assert_instance_of SalesEngine, engine
  end



end
