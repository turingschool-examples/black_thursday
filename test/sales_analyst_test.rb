require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < MiniTest::Test
  attr_reader :sa

  def setup
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_it_itializes_sales_analyst
    assert sa
  end

  def test_it_finds_number_of_items_for_each_merchant
    assert_equal 475, sa.items_per_merchant.length
  end

  def test_it_finds_average_items_per_merchant
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_it_finds_standard_deviation
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_finds_merchants_with_high_item_count
    assert_equal 52, sa.merchants_with_high_item_count.count
  end

  def test_it_returns_merchants_in_an_array_with_their_item_count
    assert_equal "Shopin1901", sa.merchants_with_item_counts[0][0].name
  end
  #more tests for method

  def test_it_returns_merchants_all_in_an_array_with_their_item_count
    assert_equal 475, sa.merchants_with_item_counts.count
  end

  def test_it_makes_average_merchant_unit_price_for_one_item
    assert_equal 150, sa.average_item_price_for_merchant(12334113).to_f
  end

  def test_it_can_average_item_prices_of_multiple_items
    assert_equal 123.5, sa.average_item_price_for_merchant(12334228).to_f
  end

  def test_it_finds_average_average_item_price_for_merchant
    assert_equal 350.29, sa.average_average_item_price_for_merchant.to_f.round(2)
  end

  def test_it_finds_all_items_unit_prices
    assert_equal 1367, sa.all_items_unit_prices.count
  end

  def test_it_finds_average_items_price
    assert_equal 251.06, sa.average_items_price.to_f.round(2)
  end

  def test_it_finds_items_price_standard_deviation
    assert_equal 2900.99, sa.items_price_standard_deviation.to_f.round(2)
  end

  def test_it_finds_golden_items
    assert_equal 5, sa.golden_items.count
  end


end
