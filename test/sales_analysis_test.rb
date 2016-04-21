require './test/test_helper'

class SalesAnalysisTest < Minitest::Test

  def test_it_exists
    assert_equal SalesAnalysis, @analysis.class
  end

  def test_it_has_sales_engine
    assert_equal SalesEngine, @analysis.engine.class
  end

  def test_average_items_per_merchant
    assert_equal 1.4, @analysis.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 0.89, @analysis.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal ["Shopin1901"], @analysis.merchants_with_high_item_count
  end

  def test_average_item_price_for_merchant
    assert_equal "16.66", @analysis.average_item_price_for_merchant(12334105).to_digits
  end

  def test_average_item_price_for_merchant_still_bigdecimal
    assert_equal BigDecimal, @analysis.average_item_price_for_merchant(12334105).class
  end

  def test_average_price_for_all_merchants
    assert_equal '43.13', @analysis.average_average_price_per_merchant.to_digits
  end

  def test_average_price_for_all_merchants_still_bigdecimal
    assert_equal BigDecimal, @analysis.average_average_price_per_merchant.class
  end

end
