require_relative 'test_helper'
require './lib/sales_engine'
require 'csv'


class SalesEngineTest < Minitest::Test

  def test_sales_engine_class_exists
    se = SalesEngine.from_csv({
      :items     => "./data/mini_items.csv",
      :merchants => "./data/mini_merchants.csv",
      })
    assert_instance_of SalesEngine, se
  end

  def test_sales_engine_can_take_hash
    se = SalesEngine.from_csv({
      :items     => "./data/mini_items.csv",
      :merchants => "./data/mini_merchants.csv",
      })
    assert se
  end

  def test_it_can_create_a_new_instance_of_merchant_repo_class
    se = SalesEngine.from_csv({
      :items     => "./data/mini_items.csv",
      :merchants => "./data/mini_merchants.csv",
      })
    assert_instance_of MerchantRepository, se.merchants
  end

  def test_it_can_create_a_new_instance_of_item_repo_class
    se = SalesEngine.from_csv({
      :items     => "./data/mini_items.csv",
      :merchants => "./data/mini_merchants.csv",
      })
    assert_instance_of ItemRepository, se.items
  end

  def test_items_searched_by_name
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    items = se.items

    assert_instance_of Item, items.find_by_name("Glitter scrabble frames")
  end

  def test_it_can_find_merchant_by_name
    se = SalesEngine.from_csv({
      :items     => "./data/mini_items.csv",
      :merchants => "./data/mini_merchants.csv",
      })
    mr = se.merchants
    merchant = mr.find_by_name("Shopin1901")
    assert merchant
  end

  def test_it_can_find_item_by_name
    se = SalesEngine.from_csv({
      :items     => "./data/mini_items.csv",
      :merchants => "./data/mini_merchants.csv",
    })

    items   = se.items
    item = items.find_by_name("510+ RealPush Icon Set")
    assert item
  end

  def test_it_can_find_another_item_by_name
    se = SalesEngine.from_csv({
      :items     => "./data/mini_items.csv",
      :merchants => "./data/mini_merchants.csv",
      })
    ir   = se.items
    item = ir.find_by_name("Glitter scrabble frames")
    assert item
  end
end
