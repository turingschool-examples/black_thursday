# frozen_string_literal: true

require './lib/sales_engine'
require './test/test_helper'
require './lib/sales_analyst'
require './lib/merchant_repository'
require 'pry'
# tests sales analyst
class SalesAnalystTest < Minitest::Test
  def setup
    @sales_engine_full = SalesEngine.new({
      items:     './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv'
      })
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
    sa.standard_deviation([10, 15, 20])
    assert_equal 5, sa.standard_deviation([10, 15, 20])
  end

  def test_it_can_return_standard_deviation_of_average_items_per_merchant
    sa = SalesAnalyst.new(@sales_engine_full)
    expected = sa.average_items_per_merchant_standard_deviation
    assert_equal 3.26, expected
    assert_equal Float, expected.class
  end

  def test_find_std_dev_above_mean
    sa = SalesAnalyst.new(@sales_engine_full)
    standard_deviation = 3.26
    mean = 2.88
    data_point = 20
    expected = sa.std_dev_above_mean(data_point, mean, standard_deviation)
    assert_equal 5.25, expected
  end

  def test_high_merchant_item_count
    sa = SalesAnalyst.new(@sales_engine_full)
    expected = sa.merchants_with_high_item_count
    assert_equal 52, expected.count
    assert_instance_of Merchant, expected[0]
  end

  def test_can_call_item_price_by_merchant
    sa = SalesAnalyst.new(@sales_engine_full)
    sa.merchants_with_high_item_count
    merchant_id = 12334105
    expected = sa.average_item_price_for_merchant(merchant_id)

    assert_equal 16.66, expected
    assert_equal BigDecimal, expected.class
  end

  def test_can_find_average_price_of_all_merchant_items
    sa = SalesAnalyst.new(@sales_engine_full)
    expected = sa.average_average_price_per_merchant

    assert_equal 350.29, expected
    assert_equal BigDecimal, expected.class
  end

  def test_can_find_average_invoices_per_merchant
    sa = SalesAnalyst.new(@sales_engine_full)
    expected = sa.average_invoices_per_merchant
    assert_equal 10.49, expected
    assert_instance_of Float, expected
  end

  def test_average_invoices_per_merchant_standard_deviation
    sa = SalesAnalyst.new(@sales_engine_full)
    expected = sa.average_invoices_per_merchant_standard_deviation
    assert_equal 3.29, expected
    assert_instance_of Float, expected
  end

  def test_top_merchants_by_invoice_count
    sa = SalesAnalyst.new(@sales_engine_full)
    expected = sa.top_merchants_by_invoice_count

    assert_equal 12, expected.count
    assert_instance_of Merchant, expected.first
  end

  def test_bottom_merchants_by_invoice_count
    sa = SalesAnalyst.new(@sales_engine_full)
    expected = sa.bottom_merchants_by_invoice_count

    assert_equal 4, expected.count
    assert_instance_of Merchant, expected.first
  end

  def test_top_days_by_invoice_count
    sa = SalesAnalyst.new(@sales_engine_full)
    actual = sa.top_days_by_invoice_count

    assert_equal 1, actual.length
    assert_equal "Wednesday", actual.first
    assert_instance_of String, actual.first
  end

  def test_number_of_invoices_per_day
    sa = SalesAnalyst.new(@sales_engine_full)
    actual = sa.number_of_invoices_per_day
    assert_equal 729, actual.first
    assert_equal 718, actual.last
  end

  def test_percent_of_total_per_status
    sa = SalesAnalyst.new(@sales_engine_full)
    actual = sa.percent_of_total_invoices_per_status

    assert_equal 3, actual.keys.count
    assert_equal 29.55, actual[:pending]
    assert_equal 56.95, actual[:shipped]
    assert_equal 13.5, actual[:returned]
  end

  def test_invoice_status
    sa = SalesAnalyst.new(@sales_engine_full)

    actual = sa.invoice_status(:pending)
    assert_equal 29.55, actual
    actual = sa.invoice_status(:shipped)
    assert_equal 56.95, actual
    actual = sa.invoice_status(:returned)
    assert_equal 13.5, actual
  end
end
