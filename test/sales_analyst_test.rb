require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
            :merchants => './fixtures/merchants_fixtures.csv',
            :items     => './fixtures/items_fixtures.csv'
            })
    @mr = se.merchants
    @sa = SalesAnalyst.new(se)
  end

  def test_average_items_per_merchant_returns_float
    assert_equal  1.75, @sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 0.53, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal 'Candisart', @sa.merchants_with_high_item_count[0].name
    assert_equal "MiniatureBikez", @sa.merchants_with_high_item_count[1].name
    assert_equal nil, @sa.merchants_with_high_item_count[2]
  end

  def test_average_item_price_for_merchant
    assert_equal 64.63, @sa.average_item_price_for_merchant(12334113).to_f
    assert_equal BigDecimal, @sa.average_item_price_for_merchant(12334113).class
  end

  def test_average_average_price_per_merchant_returns_average_price_of_all_items
    assert_equal 24.72, @sa.average_average_price_per_merchant.to_f
    assert_equal BigDecimal, @sa.average_average_price_per_merchant.class
  end

  def test_price_deviation_returns_price_deviation_for_all_items
    assert_equal 8.99, @sa.price_deviation
  end

  def test_golden_items_returns_items_that_are_two_standard_deviations_above_average
    skip
    assert_equal "", @sa.golden_items[0].name
    assert_equal "", @sa.golden_items[1].name
    assert_equal "", @sa.golden_items[2].name

    # input is items - get them from mr.find_items by id
    # put all items in items array
    # iterate through the array with find_all that match:
    # golden >= average_items_per_merchant_standard_deviation + 2
    # return those items in array.
  end
end
