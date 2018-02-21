require './test/test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def setup
    repositories = { items: './data/sample_data/items.csv',
                     merchants: './data/sample_data/merchants.csv' }
    sales_eng    = SalesEngine.new(repositories)
    @sa          = SalesAnalyst.new(sales_eng)
  end

  def test_sales_analyst_class_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_average_items_per_merchant
    assert_equal 2.5, @sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    actual = @sa.average_items_per_merchant_standard_deviation
    assert_equal 2.38, actual
  end

  def test_merchants_with_high_item_count
    actual = @sa.merchants_with_high_item_count.first.name
    assert_equal 'MiniatureBikez', actual
  end

  def test_average_item_price_for_merchant
    actual = @sa.average_item_price_for_merchant(123_341_05)
    assert_equal 0.1149e2, actual
  end

  def test_average_average_price_per_merchant
    actual = @sa.average_average_price_per_merchant
    assert_equal 21.95, actual
  end

  def test_golden_items
    skip
    assert_equal ';h', @sa.golden_items
  end
end
