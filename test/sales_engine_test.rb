require_relative 'test_helper'
require './lib/sales_engine'
require 'pry'
require 'csv'

class SalesEngineTest < Minitest:: Test
  def test_a_sales_engine_can_be_instantiated

    assert SalesEngine.new
  end
  def test_a_sales_engine_has_an_item_repository
    se = SalesEngine.new
    se.from_csv({
      :items     => "./data/items_fixture_5lines.csv",
      :merchants => "./data/merchants_5lines.csv",
    })
    assert se.item_repository
  end
  
  def test_it_can_read_CSV
    se = SalesEngine.new
    se.from_csv({
      :items     => "./data/items_fixture_5lines.csv",
      :merchants => "./data/merchants_5lines.csv",
    })
    # binding.pry
    # assert_equal "263395617", se.items_store.first[:id]
    assert_equal "12334105", se.merchant_repository.merchant_store.first.id

  end
end
