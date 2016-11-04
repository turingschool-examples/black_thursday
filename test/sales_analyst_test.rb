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

  def test_sales_analyst_can_calculate_av_items_per_merchant_with_standard_deviation
    se = SalesEngine.from_csv(file_path)
    assert_equal 3.26, SalesAnalyst.new(se).average_items_per_merchant_standard_deviation
  end

  def test_sales_analyst_can_find_merchants_that_exceed_one_standard_deviation
    se = SalesEngine.from_csv(file_path)
    assert_equal 52, SalesAnalyst.new(se).merchants_with_high_item_count.count
  end

  def test_sales_analyst_can_find_average_item_price_for_merchant_by_id
    se = SalesEngine.from_csv(file_path)
    assert_equal 1, SalesAnalyst.new(se).average_item_price_for_merchant(6)
  end

  def file_path
    {
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      }
  end
end
