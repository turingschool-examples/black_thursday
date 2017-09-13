require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < MiniTest::Test

  def setup
    se = SalesEngine.from_csv({
          :items     => "./data/items_fixture.csv",
          :merchants => "./data/merchants_fixture.csv",
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

    assert_equal 21, se.total_items
  end

  def test_it_can_find_the_items_for_each_merchant
    se = setup

    assert_instance_of Array, se.merchant_item_count
    assert_equal 21, se.merchant_item_count.count
    assert_equal 0,se.merchant_item_count[0]
    assert_equal 11, se.merchant_item_count[4]
  end

  def test_it_can_find_the_standard_deviation
    se = setup

    assert_instance_of Float, se.standard_deviation_for_merchant_items
  end
end
