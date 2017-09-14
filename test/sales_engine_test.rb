require_relative 'test_helper'
# require './lib/sales_engine'
require_relative '../lib/sales_engine'

class SalesEngineTest < MiniTest::Test

  def setup
    se = SalesEngine.from_csv({
          :items     => "./test/fixtures/items_fixture.csv",
          :merchants => "./test/fixtures/merchants_fixture.csv",
        })
    se.merchants
    se.items
    se
  end

  def test_it_exists
    skip
    se = setup

    assert ir
    assert mr
  end

  def test_it_finds_total_merchants
    se = setup

    assert_equal 21, se.total_merchants
  end

  def test_it_finds_total_items
    se = setup

    assert_equal 60, se.total_items
  end

  def test_it_can_find_the_items_for_each_merchant
    se = setup

    assert_instance_of Array, se.merchant_item_count
    assert_equal 21, se.merchant_item_count.count
    assert_equal 2,se.merchant_item_count[0]
    assert_equal 11, se.merchant_item_count[4]
  end

  def test_it_can_find_the_standard_deviation
    se = setup

    assert_instance_of Float, se.standard_deviation_for_merchant_items
    assert_equal 2.833473385894321, se.standard_deviation_for_merchant_items
  end

  def test_merchants_with_high_item_count
    se = setup

    assert_instance_of Array, se.merchants_with_high_item_count
    assert_equal 8, se.merchants_with_high_item_count.count
    assert_equal 12334123, se.merchants_with_high_item_count[0].id
  end

  def test_average_item_price_for_merchant
    se = setup

    assert_equal 9545.454545454546, se.average_item_price_for_merchant(12334123)
  end

  def test_average_average_price_per_merchant
    se = setup

    assert_equal 797.2727272727273, se.average_average_price_per_merchant
  end

  def test_find_golden_items
    se = setup

    assert_instance_of Array, se.golden_items
    assert_equal 13, se.golden_items.count
  end
end
