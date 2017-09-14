require 'bigdecimal'

require './test/test_helper'
require './lib/sales_analyst'


class SalesAnalystTest < Minitest::Test

  attr_reader :sales_analyst
  def setup
    @sales_analyst = SalesAnalyst.new(Fixture.sales_engine)
  end

  def test_an_instance_exists_and_takes_sales_engine
    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_average_items_per_merchant_returns_float
    average = sales_analyst.average_items_per_merchant
    assert_equal (4/6), average
  end

  def test_standard_deviation_returns_std
    assert_equal 3.26, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count_returns_merchants_one_std_from_avg
    skip
    high_count_merchants = sales_analyst.merchants_with_high_item_count
    assert_equal [merchant, merchant, merchant], high_count_merchants
  end

  def test_average_price_for_merchant_returns_average_price_for_the_item
    average = sales_analyst.average_item_price_for_merchant(2)
    assert_equal BigDecimal.new("2.5"), average
    assert_instance_of BigDecimal, average
  end

  def test_average_average_price_per_merchant_sums_prices_across_all_merchants
    average_average = sales_analyst.average_average_price_per_merchant
    assert_equal BigDecimal.new("1.5"), average_average
    assert_instance_of BigDecimal, average_average
  end

  def test_golden_items_returns_items_2_standard_deviations_from_average
    skip
    # assert_equal [<item>, <item>, <item>, <item>], sales_analyst.golden_items
  end



end
