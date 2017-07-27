require_relative '../lib/sales_analyst'
require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'

class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices  => "./data/invoices.csv"})
    @sa = SalesAnalyst.new(@se)
    @se_short= SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants_short_one.csv",
                              :invoices  => "./data/invoices.csv"})
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
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_do_average_item_price_for_merchant
    assert_equal 130, @sa.average_item_price_for_merchant(12335227)
  end

  def test_it_can_average_averages
    # assert_equal 10, @sa.average_average_price_per_merchant
    # assert_equal 1445, @sa_short.average_average_price_per_merchant
    assert_equal 350.29, @sa.average_average_price_per_merchant
    # assert_equal 1445, @sa_short.average_average_price_per_merchant
  end

  def test_it_returns_golden_items
    assert_instance_of Array, @sa.golden_items
    assert_equal 5, @sa.golden_items.count
    assert_equal 5, @sa.sales_engine.items.find_all_by_price_in_range(6152..10000000000).count
  end
end
