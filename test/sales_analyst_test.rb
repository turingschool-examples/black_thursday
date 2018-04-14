# frozen_string_literal: true

require_relative 'test_helper'
require './lib/sales_engine'
require 'pry'

# This is a sales analyst class

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv
    @sa = SalesAnalyst.new(@se)
    # binding.pry
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
    assert_equal @se, @sa.engine
  end

  def test_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_standard_deviation
    actual = @sa.average_items_per_merchant_standard_deviation
    assert_equal 3.26, actual
  end

  def test_merchants_with_high_item_count
    high_item_merchants = @sa.merchants_with_high_item_count

    assert_instance_of Array, high_item_merchants
    assert_instance_of Merchant, high_item_merchants[0]
    assert_equal 52, high_item_merchants.count
  end

  def test_average_item_price_for_merchant
    actual = @sa.average_item_price_for_merchant(12334105)

    assert_instance_of BigDecimal, actual
    assert_equal 16.66, actual.to_f
  end

  def test_average_average_price_per_merchant
    actual = @sa.average_average_price_per_merchant

    assert_equal 350.29, actual
    assert_instance_of BigDecimal, actual
  end

  def test_golden_items
    actual = @sa.golden_items

    assert_equal 5, actual.length
    assert_instance_of Item, actual[0]
  end
end
