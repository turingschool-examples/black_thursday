require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    items = se.items
    merchants = se.merchants
    assert_instance_of ItemRepository, items
    assert_instance_of MerchantRepository, merchants
  end

  def test_items_can_searched_via_find_by_id
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    items = se.items
    assert_instance_of Item, items.find_by_id(263395237)
  end

  def test_items_can_searched_via_find_by_name
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    items = se.items
    assert_instance_of Item, items.find_by_name("510+ RealPush Icon Set")
  end

  def test_items_can_searched_via_find_all_by_price
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    items = se.items
    assert_equal 7, items.find_all_by_price(400.00).length
  end

  def test_items_can_searched_via_find_by_merchant_id
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    items = se.items
    assert_equal 1, items.find_all_by_merchant_id("12334141").length
  end

  def test_it_returns_empty_array_with_invalid_merchant_id
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    items = se.items
    assert_equal items.find_all_by_merchant_id("kwjalkdwja"), []
  end

end
