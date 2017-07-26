require './lib/sales_analyst'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                                                                  })
    @sa = SalesAnalyst.new(@se)
    @se_short= SalesEngine.from_csv({
                              :items     => "./data/items_short_one.csv",
                              :merchants => "./data/merchants_short_one.csv",})
    @sa_short = SalesAnalyst.new(@se_short)

  end

  def test_it_can_be_initialized
    sa = SalesAnalyst.new(SalesEngine.new(0))
    assert_instance_of SalesAnalyst, sa
    assert sa
  end

  def test_it_can_do_average
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_it_can_do_standard_dev
    assert_equal 3.32, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_do_average_item_price_for_merchant
    assert_equal 13000, @sa.average_item_price_for_merchant(12335227)
  end

  def test_it_can_average_averages
    assert_equal 35029, @sa.average_average_price_per_merchant
    assert_equal 1445, @sa_short.average_average_price_per_merchant
  end

  def test_it_returns_golden_items
    assert_instance_of Array, @sa.golden_items
    assert_equal 5, @sa.golden_items.count
    assert_equal 5, @sa.sales_engine.items.find_all_by_price_in_range(615227, 10000000000).count
  end
end
