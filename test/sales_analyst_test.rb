# frozen_string_literal: true

require './lib/sales_engine'
require './test/test_helper'
require './lib/sales_analyst'
require 'pry'
# tests sales analyst
class SalesAnalystTest < Minitest::Test
  def setup
    @sales_engine_full = SalesEngine.new({ items:     './data/items.csv',
                                           merchants: './data/merchants.csv'})
  end

  def test_it_exists
    sa = SalesAnalyst.new(@sales_engine_full)
    assert_instance_of SalesAnalyst, sa
  end

  def test_all_items_per_by_merchant
    sa = SalesAnalyst.new(@sales_engine_full)
    assert_equal 475, sa.all_items_per_merchant.keys.count
    assert_equal 1367, sa.all_items_per_merchant.values.flatten.count
  end

  def test_average_items_per_merchant
    sa = SalesAnalyst.new(@sales_engine_full)

    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_can_find_sum
    sa = SalesAnalyst.new(@sales_engine_full)

    sa.find_sum([3, 4])
    assert_equal 7, sa.find_sum([3, 4])
  end

  def test_can_find_mean
    sa = SalesAnalyst.new(@sales_engine_full)

    sa.find_mean([4, 4])
    assert_equal 4, sa.find_mean([4, 4])
  end

  def test_it_can_find_standard_deviation
    sa = SalesAnalyst.new(@sales_engine_full)
    sa.find_standard_deviation([10, 15, 20])
    assert_equal 5, sa.find_standard_deviation([10, 15, 20])
  end

  def test_it_can_return_standard_deviation_of_average_items_per_merchant
    sa = SalesAnalyst.new(@sales_engine_full)
    expected = sa.average_items_per_merchant_standard_deviation
    assert_equal 3.26, expected
    assert_equal Float, expected.class
  end


end
