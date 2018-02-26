require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'date'

# This is a class for tests of the sales analyst class.
class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(
      items:     './data/items.csv',
      merchants: './data/merchants.csv',
      invoices:  './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv',
      customers: './data/customers.csv'
    )
    @sales_analyst = SalesAnalyst.new(@se)
  end

  def test_it_exists_and_sales_engine_argument
    skip
    assert_instance_of SalesAnalyst, @sales_analyst
    assert_equal @se, @sales_analyst.sales_engine
  end

  def test_for_items_per_merchant
    skip
    expected = [1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0]
    actual = @sales_analyst.items_per_merchant
    assert_equal expected, actual
  end

  def test_for_average_items_per_merchant
    skip
    assert_equal 0.29, @sales_analyst.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    skip
    actual = @sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal 0.72, actual
  end

  def test_merchants_with_high_item_count
    skip
    actual = @sales_analyst.merchants_with_high_item_count

    assert actual.is_a?(Array)
    assert actual[0].is_a?(Merchant)
    assert_equal 1, actual.count
    assert_equal 'Madewithgitterxx', actual[0].name
  end

  def test_for_average_item_price_for_merchant
    skip
    actual = @sales_analyst.average_item_price_for_merchant(12_334_185)

    assert actual.is_a?(BigDecimal)
    assert_equal 0.1117e2, actual
  end

  def test_for_average_average_price_per_merchant
    skip
    actual = @sales_analyst.average_average_price_per_merchant

    assert actual.is_a?(BigDecimal)
    assert_equal 0.324e1, actual
  end

  def test_for_item_unit_prices
    skip
    expected = [0.12e2, 0.13e2, 0.135e2, 0.7e1, 0.15e2, 0.2999e2, 0.149e3,
                0.149e2, 0.69e1, 0.4e3, 0.13e3, 0.399e1, 0.8e2, 0.6e3, 0.65e3,
                0.4e2, 0.239e2, 0.5e3, 0.239e2, 0.5e3, 0.5e1, 0.2e1]
    actual = @sales_analyst.item_unit_prices

    assert_equal expected, actual
  end

  def test_for_average_item_price
    skip
    actual = @sales_analyst.average_item_price

    assert_equal 146.36727272727273, actual
  end

  def test_for_item_price_standard_deviation
    skip
    actual = @sales_analyst.item_price_standard_deviation

    assert_equal 220.54, actual
  end

  def test_for_golden_items
    skip
    actual = @sales_analyst.golden_items

    assert actual.is_a?(Array)
    assert actual[0].is_a?(Item)
    assert_equal 'Introspection virginalle', actual[0].name
  end

  def test_for_average_invoices_per_merchant
    skip
    assert_equal 0.14, @sales_analyst.average_invoices_per_merchant
  end

  def test_for_average_invoices_per_merchant_standard_deviation
    skip
    actual = @sales_analyst.average_invoices_per_merchant_standard_deviation
    assert_equal 0.48, actual
  end

  def test_for_top_merchants_by_invoice_count
    skip
    actual = @sales_analyst.top_merchants_by_invoice_count

    assert actual.is_a?(Array)
    assert actual[0].is_a?(Merchant)
    assert_equal 1, actual.count
    assert_equal 'Candisart', actual[0].name
  end

  def test_for_bottom_merchants_by_invoice_count
    skip
    actual = @sales_analyst.bottom_merchants_by_invoice_count

    assert actual.is_a?(Array)
    assert actual.empty?
    assert_equal 0, actual.count
  end

  def test_top_days_by_invoice_count
    skip
    actual = @sales_analyst.top_days_by_invoice_count

    assert actual.is_a?(Array)
    assert actual[0].is_a?(String)
    assert_equal 1, actual.count
    assert_equal 'Friday', actual[0]
  end

  def test_for_invoice_status
    skip
    assert_equal 36.0, @sales_analyst.invoice_status(:pending)
    assert_equal 56.0, @sales_analyst.invoice_status(:shipped)
    assert_equal 8.0, @sales_analyst.invoice_status(:returned)
  end

  def test_for_total_revenue_by_date
    skip
    date = Time.parse("2012-11-23")
    assert_equal 407.67, @sales_analyst.total_revenue_by_date(date)
  end

  def test_for_top_revenue_earners
    skip
    assert @sales_analyst.top_revenue_earners.is_a?(Array)
    assert @sales_analyst.top_revenue_earners[0].is_a?(Merchant)

    assert_equal 20, @sales_analyst.top_revenue_earners.length
    assert_equal 7, @sales_analyst.top_revenue_earners(7).length
  end

  def test_for_merchants_with_pending_invoices
    assert @sales_analyst.top_revenue_earners.is_a?(Array)
    assert @sales_analyst.top_revenue_earners[0].is_a?(Merchant)
  end

  def test_for_revenue_by_merchant
    skip
    assert_equal 10, @sales_analyst.revenue_by_merchant(12334194)
  end

  def test_for_merchants_ranked_by_revenue
    skip
    assert @sales_analyst.merchants_ranked_by_revenue.is_a?(Array)
    assert @sales_analyst.merchants_ranked_by_revenue[0].is_a?(Merchant)

    assert_equal 12334634, @sales_analyst.merchants_ranked_by_revenue[0].id
  end

  def test_for_merchants_total_revenue
    skip
    assert_equal 10, @sales_analyst.merchants_ranked_by_revenue
  end

  def test_for_merchants_with_only_one_item
    assert @sales_analyst.merchants_with_only_one_item.is_a?(Array)
    assert @sales_analyst.merchants_with_only_one_item[0].is_a?(Merchant)
  end
end
