require './test/test_helper'
require "./lib/sales_engine"

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.new("./data/items.csv", "./data/merchants.csv")

    assert_instance_of SalesEngine, se
  end

  def test_se_has_an_item_repository
    se = SalesEngine.new("./data/items.csv", "./data/merchants.csv")

    assert_equal "510+ RealPush Icon Set", se.items.first.name
  end
end
