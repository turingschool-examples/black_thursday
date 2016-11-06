require_relative 'test_helper'
require './lib/standard_deviation'
require './lib/analyst_helper'

class SalesAnalystTest < Minitest::Test
  include StandardDeviation
  include AnalystHelper

  def setup
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert @sa
  end

  def test_it_knows_parent
    refute @sa.sales_engine.nil?
  end

  def test_it_can_find_the_standard_deviation
    result = @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_calculates_average_per_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_calculates_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_it_can_calculate_average_item_price
    assert_equal 16.66, @sa.average_item_price_for_merchant(12334105)
    assert_equal 33.5, @sa.average_item_price_for_merchant(12334871)
  end

  def test_it_calculates_average_average_price
    assert_equal 350.29, @sa.average_average_price_per_merchant
  end

  def test_average_method_averages
    assert_equal 2, @sa.average([1,2,3])
  end

  def test_it_can_find_merchants_with_high_item_count
    assert_equal Merchant, @sa.merchants_with_high_item_count[0].class
  end

  def test_it_can_find_golden_items
    result = @sa.golden_items
  end

end