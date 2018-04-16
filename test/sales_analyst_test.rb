require './test/test_helper'
require './lib/sales_analyst'
require 'pry'
class SalesAnalystTest < Minitest::Test
  attr_reader :sa
  def setup
    se = SalesEngine.from_csv({ items: './test/fixtures/item_fixture.csv',
                                merchants: './test/fixtures/merchant_fixture.csv'})
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_can_calculate_average_items_per_merchant
    assert_equal 1.25, sa.average_items_per_merchant
  end

  def test_it_can_calculate_standard_deviation
    assert_equal 0.5, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_find_merchants_with_high_item_count
    assert_equal 12334113, sa.merchants_with_high_item_count[0].id
  end

  def test_average_item_price_for_merchant
    assert_instance_of BigDecimal, sa.average_item_price_for_merchant(12334113)
    assert_equal 21, sa.average_item_price_for_merchant(12334113)
  end

  def test_average_average_price_per_merchant
    assert_instance_of BigDecimal, sa.average_average_price_per_merchant
  end
end
