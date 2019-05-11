# frozen_string_literal: true

require_relative 'test_helper'
require './lib/sales_engine'
require 'pry'

# This is a sales analyst class

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv
    @sa = SalesAnalyst.new(@se)
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

  def test_average_invoices_per_merchant
    actual = @sa.average_invoices_per_merchant

    assert_equal 10.49, actual
    assert_instance_of Float, actual
  end

  def test_average_invoices_per_merchant_standard_deviation
    actual = @sa.average_invoices_per_merchant_standard_deviation

    assert_equal 3.29, actual
    assert_instance_of Float, actual
  end

  def test_top_merchants_by_invoice_count
    actual = @sa.top_merchants_by_invoice_count

    assert_equal 12, actual.length
  end

  def test_bottom_merchants_by_invoice_count
    actual = @sa.bottom_merchants_by_invoice_count

    assert_equal 4, actual.length
  end

  def test_top_days_by_invoice_count
    actual = @sa.top_days_by_invoice_count

    assert_equal ["Wednesday"], actual
  end

  def test_invoice_status
    actual   = @sa.invoice_status(:pending)
    actual_1 = @sa.invoice_status(:shipped)
    actual_2 = @sa.invoice_status(:returned)

    assert_equal 29.55, actual
    assert_equal 56.95, actual_1
    assert_equal 13.5, actual_2
  end

  def test_invoice_paid_in_full
    assert_equal true, @sa.invoice_paid_in_full?(1)
    assert_equal false, @sa.invoice_paid_in_full?(204)
    assert_equal false, @sa.invoice_paid_in_full?(203)
  end

  def test_invoice_total
    assert_equal 21067.77, @sa.invoice_total(1)
  end
end
