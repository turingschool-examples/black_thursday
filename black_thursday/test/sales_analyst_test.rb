require_relative 'test_helper'
require_relative './../lib/sales_engine'
require_relative './../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  attr_reader :engine,
              :analyst

  def setup
    @engine = SalesEngine.from_csv(
      items: './test/fixtures/truncated_items.csv',
      merchants: './test/fixtures/truncated_merchants.csv',
      invoices: './test/fixtures/truncated_invoices.csv',
      invoice_items: './test/fixtures/truncated_invoice_items.csv',
      transactions: './test/fixtures/truncated_transactions.csv',
      customers: './test/fixtures/truncated_customers.csv'
    )

    @analyst = SalesAnalyst.new(@engine)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, analyst
  end

  def test_it_can_calculate_average_items_per_merchant
    assert_equal 0.35, analyst.average_items_per_merchant
  end

  def test_can_find_average_item_price_for_merchant
    result = analyst.average_item_price_for_merchant(12334185)
    assert_equal 10.78, result
  end

  def test_can_find_average_average_price_per_merchant
    result = analyst.average_average_price_per_merchant

    assert_equal 0.1206e2, result
  end

  def test_count_merchants
    assert_equal 60.0, analyst.count_merchants
  end

  def test_count_items
    assert_equal 21.0, analyst.count_items
  end

  def test_can_find_merchant_items_by_id
    assert_equal 6, analyst.merchant_items_by_id(12334185).length
  end

  def test_sum_prices
    assert_equal 0.647e2, analyst.sum_prices(12334185)
  end

  def test_avg
    expected = BigDecimal.new(0.10783333333333333333333333333e2, 4).round(2)
    actual = BigDecimal.new(analyst.avg(12334185), 4).round(2)
    assert_equal expected, actual
  end

  def test_standard_deviation_of_item_price
    assert_equal 166.73, analyst.standard_deviation_of_item_price
  end

  def test_can_find_average_items_per_merchant_standard_deviation
    result = analyst.average_items_per_merchant_standard_deviation
    assert_equal 0.85, result
  end

  def test_one_standard_deviation_of_items_per_merchant
    assert_equal 1.2, analyst.one_standard_deviation_of_merchant_items
  end

  def test_can_find_merchants_with_high_item_count
    assert_equal 2, analyst.merchants_with_high_item_count.length
  end

  def test_merchants_with_no_items
    assert_equal 54, analyst.merchants_with_no_items.length
  end

  def test_merchants_with_one_or_more_items
    assert_equal 6, analyst.merchants_with_one_or_more_items.length
  end

  def test_names_of_merchants_with_no_items
    assert_equal 54, analyst.names_of_merchants_without_items.length
  end

  def test_names_of_merchants_with_at_least_one_item
    expected = ["Candisart", "Keckenbauer", "thepurplepenshop", "Madewithgitterxx", "ElisabettaComotto", "MomsTshirts"]

    assert_equal expected, analyst.names_of_merchants_with_at_least_one_item
  end

  def test_two_standard_deviations_above_price
    assert_equal 0.34552e3, analyst.two_standard_deviations_above_price
  end

  def test_golden_items
    assert_equal 2, analyst.golden_items.length
  end

  def test_average_invoices_per_merchant
    assert_equal 1.68, analyst.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 1.58, analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    assert_equal [], analyst.top_merchants_by_invoice_count
  end

  def test_bottom_merchants_by_invoice_count
    assert_equal [], analyst.bottom_merchants_by_invoice_count
  end
end
