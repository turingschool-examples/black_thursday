require_relative './test_helper'
require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/merchant'
require './lib/item'


class SalesEngineTest < Minitest::Test
  def test_it_exists_and_has_attributes
    # expected = ({items: "a", merchants: "b"}, SalesEngine)
    # sales = SalesEngine.new(expected)
    sales = SalesEngine.new({items: "a", merchants: "b"})

    assert_instance_of SalesEngine, sales
  end
end
