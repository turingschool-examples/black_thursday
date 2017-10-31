require_relative 'test_helper'
require 'csv'
require './lib/merchant'
require './lib/merchant_repository'
require './lib/item'
require './lib/item_repository'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @engine = SalesEngine.from_csv(
      #items: "./data/items.csv",
      merchants: "./data/merchants.csv"
    )
  end

  def test_it_loads_a_merchant_repository
    assert_equal 475, @engine.merchants.all.count
  end

  def test_it_loads_an_item_repository
    skip
  end
end
