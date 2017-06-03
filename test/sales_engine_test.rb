require './test/test_helper'
require_relative '../lib/sales_engine'
require 'pry'


class SalesEngineTest < MiniTest::Test

  def test_items_searched_by_id
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"})
    items = se.items
    assert_instance_of Item, items.find_by_id(263395237)
  end

  def test_items_searched_by_all_price
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"})
    items = se.items

    assert_equal 6, items.find_all_by_price(300).length
    refute_equal 2, items.find_all_by_price(300).length
  end

  def test_items_searched_by_name
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"})
    items = se.items

    assert_instance_of Item, items.find_by_name("Glitter scrabble frames")
  end

  def test_items_searched_by_merchant_id
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv"})
    items = se.items

    assert_equal 1, items.find_all_by_merchant_id(12334141).length
    refute_equal 2, items.find_all_by_merchant_id(12334141).length
  end


end
