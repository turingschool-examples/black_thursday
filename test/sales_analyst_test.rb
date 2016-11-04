require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  def test_sales_analyst_class_exists
    se = SalesEngine.from_csv(file_path)
    assert_instance_of SalesAnalyst, SalesAnalyst.new(se)
  end

  def test_sales_analyst_knows_average_items_per_merchant
    se = SalesEngine.from_csv(file_path)
    assert_equal 2.88, SalesAnalyst.new(se).average_items_per_merchant
  end

  def test_sales_analyst_can_calculate_average_items_per_merchant_with_standard_deviation
    se = SalesEngine.from_csv(file_path)
    assert_equal 3.26, SalesAnalyst.new(se).average_items_per_merchant_standard_deviation
  end
``
  def test_sales_analyst_can_find_merchants_that_exceed_one_standard_deviation
    se = SalesEngine.from_csv(file_path)
    assert_equal 52, SalesAnalyst.new(se).merchants_with_high_item_count.count
  end

  def test_sales_analyst_can_find_average_item_price_for_merchant_by_id
    se = SalesEngine.from_csv(file_path)
    assert_equal 33.5, SalesAnalyst.new(se).average_item_price_for_merchant(12334871)
    assert_equal 813.33, SalesAnalyst.new(se).average_item_price_for_merchant(12334371).round(2)
  end

  def test_sales_analyst_can_find_the_average_average_price_per_merchant
    se = SalesEngine.from_csv(file_path)
    assert_equal 350.29, SalesAnalyst.new(se).average_average_price_per_merchant
  end

  def test_sales_analyst_can_find_the_golden_items
    se = SalesEngine.from_csv(file_path)
    assert_equal 5, SalesAnalyst.new(se).golden_items.count
  end

  def file_path
    {
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      }
  end
end
