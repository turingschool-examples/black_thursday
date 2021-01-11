require_relative './test_helper'
require './lib/sales_analyst'
require './lib/standard_deviation'
require 'bigdecimal/util'

class SalesAnalystTest < Minitest::Test
  include StandardDeviation

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./fixture_data/items_fixtures_file.csv",
      :merchants => "./fixture_data/merchants_sample.csv",
      })
  end

  def test_it_exists_and_has_attributes
    assert_instance_of SalesAnalyst, @se.analyst
  end

  def test_average_items_per_merchant
    assert_equal 2.42, @se.analyst.average_items_per_merchant
  end

  def test_reduce_shop_items
    assert_equal 29, @se.analyst.reduce_shop_items.values.flatten.count
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 2.84, @se.analyst.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal 1, @se.analyst.merchant_names_with_high_item_count.count
    assert_equal Merchant, @se.analyst.merchants_with_high_item_count[0].class
  end

  def test_average_item_price_for_merchant
    assert_equal 29.99, @se.analyst.average_item_price_for_merchant(12334105)
  end

  def test_second_deviation_above_unit_price
    assert_equal 0.54076e3, @se.analyst.second_deviation_above_unit_price
  end

  def test_average_average_price_per_merchant
    expected = 0.674e2
    assert_equal expected.to_d, @se.analyst.average_average_price_per_merchant
  end

  def test_golden_items
    assert_equal Array, @se.analyst.golden_items.class
    assert_equal Item, @se.analyst.golden_items[1].class
    assert_equal 5, @se.analyst.golden_items.count
  end
end
