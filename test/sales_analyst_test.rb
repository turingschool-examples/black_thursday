require './test/test_helper'
require './test/fixtures/mock_sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def setup
    sales_eng = MockSalesEngine.new
    @sa       = SalesAnalyst.new(sales_eng)
  end

  def test_sales_analyst_class_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_average_items_per_merchant
    skip
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    skip
    actual = @sa.average_items_per_merchant_standard_deviation
    assert_equal 3.26, actual
  end

  def test_merchants_with_high_item_count
    skip
    actual = @sa.merchants_with_high_item_count
  # [merchant, merchant, merchant]
  end

  def test_average_item_price_for_merchant
    skip
    actual = @sa.average_item_price_for_merchant(12334159)
  #  # => BigDecimal
  end

  def test_average_average_price_per_merchant
    skip
    actual = @sa.average_average_price_per_merchant
  #  # => BigDecimal
  end

  def test_golden_items
    skip
  # sa.golden_items # => [<item>, <item>, <item>, <item>]
  end
end
