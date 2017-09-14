require './test/test_helper'
require 'bigdecimal'
require './lib/sales_analyst'


class SalesAnalystTest < Minitest::Test

  def setup
    se = Fixture.sales_engine
    @SalesAnalyst = SalesAnalyst.new(se)
  end

  def test_an_instance_exists_and_takes_se
    assert_instance_of SalesAnalyst, @SalesAnalyst
  end

  def test_items_per_merchant_returns_float
    assert_equal 0.8, @SalesAnalyst.average_items_per_merchant
  end

  def test_standard_deviation_returns_std
    skip
    assert_equal 3.26, @SalesAnalyst.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count_returns_merchants_one_std_from_avg
    skip
    high_count_merchants = @SalesAnalyst.merchants_with_high_item_count
    assert_equal [merchant, merchant, merchant], high_count_merchants
  end

  def test_average_price_for_merchant_returns_average_price_for_the_item
    average = @SalesAnalyst.average_item_price_for_merchant(2)
    assert_equal 4.5, average
    assert_instance_of BigDecimal, average
  end

  def test_average_average_price_per_merchant_sums_prices_across_all_merchants
    average_average = @SalesAnalyst.average_average_price_per_merchant
    assert_equal 1.5, average_average
    assert_instance_of BigDecimal, average_average
  end

  def test_golden_items_returns_items_2_standard_deviations_from_average
    skip
    # assert_equal [<item>, <item>, <item>, <item>], @SalesAnalyst.golden_items
  end



end
