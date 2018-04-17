require './test/test_helper'
require './lib/sales_analyst'
require 'pry'
class SalesAnalystTest < Minitest::Test
  attr_reader :sa
  def setup
    se = SalesEngine.from_csv({ items: './data/items.csv',
                                merchants: './data/merchants.csv'})
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_can_calculate_average_items_per_merchant
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_it_can_calculate_standard_deviation
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_find_merchants_with_high_item_count
    assert_equal 12334123, sa.merchants_with_high_item_count[0].id
  end

  def test_average_item_price_for_merchant
    assert_instance_of BigDecimal, sa.average_item_price_for_merchant(12334113)
  end

  def test_average_average_price_per_merchant
    assert_instance_of BigDecimal, sa.average_average_price_per_merchant
  end

  def test_average_item_cost
    assert_equal 251.06, sa.average_item_cost
  end

  def test_golden_items
    assert_instance_of Array, sa.golden_items
    assert_instance_of Item, sa.golden_items[0]
    assert 263410685, sa.golden_items[0].id
  end
end
