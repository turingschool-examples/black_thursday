require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative 'test_helper'
require 'pry'

# test for sales analyst class
class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(items: './test/fixtures/items.csv',
                               merchants: './test/fixtures/merchants.csv')
    @sales_analyst = SalesAnalyst.new(@se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
    assert_equal @se, @sales_analyst.sales_engine
  end

  def test_average_items_per_merchant
    assert_equal 1.25, @sales_analyst.average_items_per_merchant
  end

  def test_standard_deviation
    assert_equal 1.5, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    high_count = @sales_analyst.merchants_with_high_item_count
    assert_instance_of Array, high_count
    assert_instance_of Merchant, high_count[0]
    assert_equal 2, high_count[0].id
  end

  def test_average_item_price_for_merchant
    assert_instance_of BigDecimal, @sales_analyst.average_item_price_for_merchant(2)
    assert_equal BigDecimal.new('16.66'), @sales_analyst.average_item_price_for_merchant(2)
  end

  def test_average_average_price_per_merchant
    assert_equal BigDecimal.new('7.35'), @sales_analyst.average_average_price_per_merchant
  end

  def test_golden_items
    se = SalesEngine.from_csv(items: './test/fixtures/items.csv',
                              merchants: './test/fixtures/merchants.csv')
    sales_analyst = SalesAnalyst.new(se)

    assert_instance_of Array, sales_analyst.golden_items
    assert_instance_of Item, sales_analyst.golden_items[0]
    assert_equal 4, sales_analyst.golden_items.length
  end
end
