require_relative './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_exists_and_has_attributes
    sales = SalesEngine.new({items: "a", merchants: "b"})

    assert_instance_of SalesEngine, sales
  end
end
