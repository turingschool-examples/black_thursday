require_relative '/test_helper'
require_relative "../lib/sales_engine"

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.new("./data/items.csv", "./data/merchants.csv")

    assert_instance_of SalesEngine, se
  end

  def test_se_has_an_item_repository
    se = SalesEngine.new("./data/items.csv", "./data/merchants.csv")

    assert_equal "510+ RealPush Icon Set", se.items.items.first.name
    assert_equal
  end

  def test_item_merchant_can_be_found
    se = SalesEngine.new("./data/items.csv", "./data/merchants.csv")

    assert_equal "jejum", se.find_merchant(12334141).name
  end
end
