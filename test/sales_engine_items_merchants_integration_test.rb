require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items     => "./data/test_items.csv",
      :merchants => "./data/test_merchants.csv"
    })
  end
  
  def test_it_exists
    assert SalesEngine
  end

  def test_items_are_found_from_merchant_level
    merchant = @sales_engine.merchants.find_by_id(12334185)
    assert_equal 3, merchant.items.count
    assert merchant.items.all?{|item| item.class == Item}
  end

  def test_items_are_found_from_different_merchant
    merchant = @sales_engine.merchants.find_by_id(12334195)
    assert_equal 12, merchant.items.count
    assert merchant.items.all?{|item| item.class == Item}
  end

  def test_items_are_found_from_different_merchant_with_one_item
    merchant = @sales_engine.merchants.find_by_id(12334257)
    assert_equal 1, merchant.items.count
    assert merchant.items.one?{|item| item.class == Item}
  end

  def test_merchant_is_found_from_item_level
    item = @sales_engine.items.find_by_id(263395237)
    merchant = item.merchant
    assert_equal Merchant, merchant.class
    assert merchant.items.include?(item)
  end

  def test_merchant_is_found_from_different_item
    item = @sales_engine.items.find_by_id(263396517)
    merchant = item.merchant
    assert_equal Merchant, merchant.class
    assert merchant.items.include?(item)
  end

end