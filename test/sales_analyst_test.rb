require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative 'mocks/test_engine'

class SalesAnalystTest < Minitest::Test
  def setup
    @sa = SalesAnalyst.new MOCK_SALES_ENGINE
  end

  def test_does_create_sales_analyst
    assert_instance_of SalesAnalyst, @sa
  end

  def test_does_have_sales_engine
    assert_instance_of SalesEngine, @sa.sales_engine
  end

  def test_can_calculate_average_item_cost
    assert_equal Rational(95.0 / 4.0), @sa.average_item_cost
  end

  def test_can_calculate_item_cost_standard_deviation
    assert_equal Math.sqrt(Rational(79.0 / 14.0)) * 5, @sa.item_cost_standard_deviation
  end

  def test_can_find_golden_items
    items = @sa.golden_items
    assert_instance_of Array, items
    assert_equal 1, items.length
    assert_equal 'Item E', items.first.name
  end
end
