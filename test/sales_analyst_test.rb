require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative 'test_helper'
require 'pry'

# test for sales analyst class
class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(items: './test/fixtures/items.csv',
                               merchants: './test/fixtures/merchants.csv')
    @sa = SalesAnalyst.new(@se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
    assert_equal @se, @sa.sales_engine
  end

  def test_average_items_per_merchant
    assert_equal 1.25, @sa.average_items_per_merchant
  end

  def test_standard_deviation
    assert_equal 1.5, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    high_count = @sa.merchants_with_high_item_count
    assert_instance_of Array, high_count
    assert_instance_of Merchant, high_count[0]
    assert_equal 2, high_count[0].id
  end

  def test_average_item_price_for_merchant
    assert_instance_of BigDecimal, @sa.average_item_price_for_merchant(2)
    assert_equal BigDecimal.new('16.66'), @sa.average_item_price_for_merchant(2)
  end

  def test_average_average_price_per_merchant
    assert_equal BigDecimal.new('7.35'), @sa.average_average_price_per_merchant
  end

  def test_all_item_prices
    assert_instance_of Array, @sa.all_item_prices
    assert_equal 5, @sa.all_item_prices.length
    assert_instance_of BigDecimal, @sa.all_item_prices[0]
  end

  def test_golden_items
    se = SalesEngine.from_csv(items: './test/fixtures/items.csv',
                              merchants: './test/fixtures/merchants.csv')
    sales_analyst = SalesAnalyst.new(se)

    assert_instance_of Array, sales_analyst.golden_items
    # assert_instance_of Item, sales_analyst.golden_items[0]
    assert_equal 0, sales_analyst.golden_items.length
  end
end
