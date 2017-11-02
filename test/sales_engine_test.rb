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
      :items     => "./test/fixtures/items_fixture_5lines.csv",
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })

    assert se.items
    assert se.merchants
  end

  def test_merchant_returns_instance_of_Repositories
    se= SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture_5lines.csv",
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })

    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of ItemRepository, se.items
  end

  def test_it_can_find_merchants_by_name_from_Sales_Engine
    se= SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture_5lines.csv",
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })
    mr = se.merchants
    merchant1 = mr.find_by_name("LolaMarleys")
    merchant2 = mr.find_by_name("Keckenbauer")
    result1 =  mr.merchants[3]
    result2 =  mr.merchants[4]

    assert_equal result1, merchant1
    assert_equal result2, merchant2
  end

  def test_it_can_find_items_by_name_from_Sales_Engine
    se= SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture_5lines.csv",
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })
    ir = se.items
    item = ir.find_by_name("510+ RealPush Icon Set")
    result =  ir.items[0]

    assert_equal result, item
  end

  def test_merchants_can_have_items
    se= SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture_5lines.csv",
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })

      mr = se.merchants.find_by_name("LolaMarleys")
  end

  def test_it_can_match_merchants_with_items
    se= SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture_5lines.csv",
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })
    merchant = se.merchants.find_by_id(12334112)
    ir = se.items

    result = ["Disney scrabble frames", "I Love You to the Moon and Back"]
    assert_equal 2, merchant.items.count
  end

end
