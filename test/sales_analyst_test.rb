require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa

  def setup
    se = SalesEngine.from_csv({items: "./sa_fixtures/items.csv",
                           merchants: "./sa_fixtures/merchants.csv",
                            invoices: "./sa_fixtures/invoices.csv"
                             })
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_can_calculate_average_items_per_merchant
    assert_equal 2.0, sa.average_items_per_merchant
  end

  def test_it_can_calculate_std_deviation_for_avg_items_per_merchant
    assert_equal 0.47, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_determine_merchants_with_high_item_count
    actual = sa.merchants_with_high_item_count
    assert_equal 0, actual.count
  end

  def test_it_can_calculate_average_price_item_price_per_merchant
    actual = sa.average_item_price_for_merchant(12334105)
    assert_instance_of BigDecimal, actual
    assert_equal 0.03, actual
  end

  def test_it_can_avg_the_avgs_of_all_merchant_prices
    actual = sa.average_average_price_per_merchant
    assert_instance_of BigDecimal, actual
    assert_equal 0.05, actual
  end
end
