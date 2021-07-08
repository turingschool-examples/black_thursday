require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  attr_reader :se, :sa

  def setup
    @se = SalesEngine.from_csv({items: "./test/fixtures/items_fixture.csv",
                                merchants: "./test/fixtures/merchant_fixture.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv",
                                invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                transactions: "./test/fixtures/transactions_fixtures.csv",
                                customers: "./data/customers.csv"})
    @sa = SalesAnalyst.new(@se)
  end

  def test_average_items
    assert_equal 1.1, sa.average_items_per_merchant
  end

  def test_standard_deviation
    assert_equal 2.25, sa.average_items_per_merchant_standard_deviation
  end

  def test_average_average_price_per_merchant
    skip
    sa.average_item_price_for_merchant(12334159)
    assert_equal 5.65, sa.average_average_price_per_merchant
  end

  def test_average_invoices_per_merchant
    assert_equal 3.02, sa.average_invoices_per_merchant
  end

  def test_invoices_standard_deviation
    assert_equal 2.45, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_for_top_merchant_by_invoice
    assert_equal [], sa.top_merchants_by_invoice_count
  end

  def test_top_days_by_invoice_count
    assert_equal ["Sunday"], sa.top_days_by_invoice_count
  end

  def test_that_it_returns_all_statuses
    assert_equal 299, sa.status_array.count
  end

  def test_for_invoice_status
    assert_equal 32.44, sa.invoice_status(:pending)
    assert_equal 55.52, sa.invoice_status(:shipped)
    assert_equal 12.04, sa.invoice_status(:returned)
  end

  def test_for_merchants_with_only_one_item
    assert_equal 19, sa.merchants_with_only_one_item.length
  end

  def test_merchants_with_only_one_item_registered_in_month_returns_month
    actual = sa.merchants_with_only_one_item_registered_in_month("January")
    assert_equal 2, actual.length
    assert_instance_of Merchant, actual.first

    actual2 = sa.merchants_with_only_one_item_registered_in_month("March")
    assert_equal 2, actual.length
    assert_instance_of Merchant, actual2.first
  end

  def test_merchants_with_pending_invoices
    actual = sa.merchants_with_pending_invoices
    assert_equal 49, actual.length
  end

  def test_revenue_by_merchant
    assert_equal 0, sa.revenue_by_merchant(12334442)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_can_calculate_average_items_per_merchant
    assert_equal 1.1, sa.average_items_per_merchant
  end

  def test_it_can_calculate_std_deviation_for_avg_items_per_merchant
    assert_equal 2.25, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_determine_merchants_with_high_item_count
    actual = sa.merchants_with_high_item_count
    assert_equal 2, actual.count
  end

  def test_it_can_calculate_average_price_item_price_per_merchant
    actual = sa.average_item_price_for_merchant(12334105)
    assert_instance_of BigDecimal, actual
  end

  def test_it_can_find_golden_items
    skip
    assert_equal 5, sa.golden_items.count
  end

  def test_it_can_return_avg_invoices_per_merchant
    actual = sa.average_invoices_per_merchant
    assert_equal 3.02, actual
  end

  def test_it_can_find_avg_invoices_per_merchant_std_dev
    actual = sa.average_invoices_per_merchant_standard_deviation
    assert_equal 2.45, actual
  end

  def test_it_returns_top_performing_merchants
    actual = sa.top_merchants_by_invoice_count
    assert_equal 0, actual.count
  end

  def test_it_can_return_poor_performing_merchants
    actual = sa.bottom_merchants_by_invoice_count
    assert_equal 0, actual.count
  end

  def test_it_finds_top_days_by_invoice_count
    actual = sa.top_days_by_invoice_count
    assert_equal "Sunday", actual[0]
    assert_equal 1, actual.count
  end

  def test_it_returns_percentage_of_pending_status
    actual = sa.invoice_status(:pending)
    assert_equal 32.44, actual
  end

  def test_can_return_less_than_20_buyers
    assert_equal 5, sa.top_revenue_earners(5).count
  end

end
