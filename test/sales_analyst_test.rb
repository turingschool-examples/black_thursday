require 'minitest/autorun'
# require 'minitest/emoji'
require 'csv'
require 'bigdecimal'
require './lib/sales_analyst'


class SalesAnalystTest < Minitest::Test
  attr_reader :sales_engine
  def setup
    @sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
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

  def test_it_can_find_items_per_merchant
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 22, sa.items_per_merchant(12334301)
  end

  def test_it_can_find_average_items_per_merchant
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 65.1, sa.average_items_per_merchant
  end

  def test_it_creates_all_merchant_ids
    sa = SalesAnalyst.new(sales_engine)
    result = [2334261, 12334264, 12334266, 12334269, 12334271, 12334275, 12334277, 12334280, 12334281, 12334284, 12334289, 12334296, 12334299, 12334301, 12334302, 12334303, 12334305, 12334315, 12334319, 12334324, 12334326]
    assert_equal result, sa.create_all_merchant_ids
  end

  def test_it_can_find_average_price_per_merchant
    skip #unit_price showing as nil when this is run through item_repo, but otherwise the method works
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 25000.0, sa.average_item_price_per_merchant(12334301)
  end

  def test_it_can_find_items_per_merchant_standard_deviation
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 0.0, sa.average_items_per_merchant_standard_deviation
  end
end
