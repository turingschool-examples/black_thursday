require './test/test_helper'

class SalesAnalystTest < Minitest::Test

  def test_it_exists
    assert_equal SalesAnalyst, @analyst.class
  end

  def test_it_has_sales_engine
    assert_equal SalesEngine, @analyst.engine.class
  end

  def test_average_items_per_merchant
    assert_equal 1.4, @analyst.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 0.89, @analyst.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    high_item_merchants = @analyst.merchants_with_high_item_count
    high_item_merchants = high_item_merchants.map {|merchant| merchant.name}
    assert_equal ["Shopin1901"], high_item_merchants
  end

  def test_average_item_price_for_merchant
    assert_equal "16.66", @analyst.average_item_price_for_merchant(12334105).to_digits
    assert_equal BigDecimal, @analyst.average_item_price_for_merchant(12334105).class
  end

  def test_average_price_for_all_merchants
    assert_equal '43.13', @analyst.average_average_price_per_merchant.to_digits
    assert_equal BigDecimal, @analyst.average_average_price_per_merchant.class
  end

  def test_average_price_of_items
    assert_equal '35.57', @analyst.average_price_of_items.to_digits
    assert_equal BigDecimal, @analyst.average_price_of_items.class
  end

end
