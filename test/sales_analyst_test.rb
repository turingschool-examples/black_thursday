require './test/test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def setup
    repositories = {items: './data/items.csv',
                merchants: './data/merchants.csv'}
    sales_eng    = SalesEngine.new(repositories)
    @sa          = SalesAnalyst.new(sales_eng)
  end

  def test_sales_analyst_class_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    actual = @sa.average_items_per_merchant_standard_deviation
    assert_equal 3.26, actual
  end

  def test_merchants_with_high_item_count
    actual = @sa.merchants_with_high_item_count
    assert_equal ";h", actual
# [merchant, merchant, merchant]
  end

  def test_average_item_price_for_merchant
    actual = @sa.average_item_price_for_merchant(12334159)
    assert_equal 0.315e2, actual
  end

  def test_average_average_price_per_merchant
    actual = @sa.average_average_price_per_merchant
    assert_equal 350.29, actual
  end

  def test_golden_items
    skip
    assert_equal ";h", @sa.golden_items
# [<item>, <item>, <item>, <item>]
  end
end
