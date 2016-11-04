require 'minitest/autorun'
require 'minitest/emoji'
require 'csv'
require 'bigdecimal'
require './lib/sales_analyst'


class SalesAnalystTest < Minitest::Test
  attr_reader :sales_engine
  def setup
    @sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",})
  end

  def test_it_exists
    sa = SalesAnalyst.new(sales_engine)
    assert_equal SalesAnalyst, sa.class
  end

  def test_parent_is_sales_engine
    sa = SalesAnalyst.new(sales_engine)
    assert_equal SalesEngine, sa.parent.class
  end

  def test_it_can_find_items_per_merchant
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 1, sa.items_per_merchant(12334301)
    assert_equal 2, sa.items_per_merchant(12334269)
    assert_equal 3, sa.items_per_merchant(12336957)
  end

  def test_it_can_find_average_items_per_merchant
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_it_creates_all_merchant_ids
    sa = SalesAnalyst.new(sales_engine)
    result = sa.create_all_merchant_ids
    assert_equal 475, result.length
  end

  def test_it_can_find_average_item_price_per_merchant
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 25000.0, sa.average_item_price_per_merchant(12336957)
  end

  def test_it_can_find_items_per_merchant_standard_deviation
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 238, sa.average_items_per_merchant_standard_deviation
  end
end