require 'minitest/autorun'
require 'minitest/emoji'
require 'csv'
require 'bigdecimal'
require './lib/sales_analyst'


class SalesAnalystTest < Minitest::Test
  attr_reader :sales_engine
  def setup
    @sales_engine = SalesEngine.from_csv({
      :items     => "./data/small_item_file.csv",
      :merchants => "./data/small_merchant_file.csv",})
  end

  def test_it_exists
    sa = SalesAnalyst.new(sales_engine)
    assert_equal SalesAnalyst, sa.class
  end

  def test_parent_is_sales_engine
    sa = SalesAnalyst.new(sales_engine)
    assert_equal SalesEngine, sa.parent.class
  end

  def test_it_can_find_average_items_per_merchant
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 0.95, sa.average_items_per_merchant
  end

  def test_it_can_find_average_price_per_merchant
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 0.0, sa.average_item_price_per_merchant(12334302)
  end
end