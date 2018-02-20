require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(
      items:     './test/fixtures/items_list_truncated.csv',
      merchants: './test/fixtures/merchants_list_truncated.csv'
    )
    @sales_analyst = SalesAnalyst.new(@se)
  end

  def test_it_exists_and_sales_engine_argument
    assert_instance_of SalesAnalyst, @sales_analyst
    assert_equal @se, @sales_analyst.sales_engine
  end

  def test_for_items_per_merchant
    assert_equal [1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3], @sales_analyst.items_per_merchant
  end

  def test_for_average_items_per_merchant
    assert_equal 0.3, @sales_analyst.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    expected = @sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal 0.7326950970650465, expected
  end

  def test_merchants_with_high_item_count
    expected = @sales_engine.merchants_with_high_item_count
    
  end
end
