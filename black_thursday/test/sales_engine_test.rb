require_relative 'test_helper'
require 'csv'
require_relative './../lib/merchant'
require_relative './../lib/merchant_repository'
require_relative './../lib/item'
require_relative './../lib/item_repository'
require_relative './../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @engine = SalesEngine.from_csv(
      items: "./test/fixtures/truncated_items.csv",
      merchants: "./test/fixtures/truncated_merchants.csv"
    )
  end

  def test_it_loads_a_merchant_repository
    assert_equal 60, @engine.merchants.all.count
  end

  def test_it_loads_an_item_repository
    assert_equal 21, @engine.items.all.count
  end
end
