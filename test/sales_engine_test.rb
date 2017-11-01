require_relative 'test_helper'
require './lib/sales_engine'
require 'pry'
require 'csv'

class SalesEngineTest < Minitest:: Test
  def test_a_sales_engine_can_be_instantiated
    result = SalesEngine.new

    assert_instance_of SalesEngine, result
  end

  def test_a_sales_engine_has_an_item_repository
    se= SalesEngine.from_csv({
      :items     => "./data/items_fixture_5lines.csv",
      :merchants => "./data/merchants_5lines.csv",
    })

    assert se.items
    assert se.merchants
  end

  def test_merchant_returns_instance_of_Repositories
    se= SalesEngine.from_csv({
      :items     => "./data/items_fixture_5lines.csv",
      :merchants => "./data/merchants_5lines.csv",
    })

    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of ItemRepository, se.items
  end

  def test_it_can_read_find_merchants_by_name_from_Sales_Engine
    se= SalesEngine.from_csv({
      :items     => "./data/items_fixture_5lines.csv",
      :merchants => "./data/merchants_5lines.csv",
    })
    mr = se.merchants
    merchant = mr.find_by_name("LolaMarleys")
    result =  mr.merchants[3]

    assert_equal result, merchant
  end

  def test_it_can_read_find_items_by_name_from_Sales_Engine
    se= SalesEngine.from_csv({
      :items     => "./data/items_fixture_5lines.csv",
      :merchants => "./data/merchants_5lines.csv",
    })
    ir = se.items
    item = ir.find_by_name("510+ RealPush Icon Set")
    result =  ir.items[0].name

    assert_equal result, item
  end
end
