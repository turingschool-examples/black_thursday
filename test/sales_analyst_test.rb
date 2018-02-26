require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

# This is a class for tests of the sales analyst class.
class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(
      items:     './test/fixtures/items_list_truncated.csv',
      merchants: './test/fixtures/merchants_list_truncated.csv',
      invoices:  './test/fixtures/invoices_list_truncated.csv',
      invoice_items: './test/fixtures/invoice_items_list_truncated.csv',
      transactions: './test/fixtures/transactions_list_truncated.csv',
      customers: './test/fixtures/customer_list_truncated.csv'
    )
    @sales_analyst = SalesAnalyst.new(@se)
  end

  def test_it_exists_and_sales_engine_argument
    assert_instance_of SalesAnalyst, @sales_analyst
    assert_equal @se, @sales_analyst.sales_engine
  end

  def test_for_items_per_merchant
    expected = [1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0]
    actual = @sales_analyst.items_per_merchant
    assert_equal expected, actual
  end

  def test_for_average_items_per_merchant
    assert_equal 0.27, @sales_analyst.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    actual = @sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal 0.7, actual
  end

  def test_merchants_with_high_item_count
    actual = @sales_analyst.merchants_with_high_item_count

    assert actual.is_a?(Array)
    assert actual[0].is_a?(Merchant)
    assert_equal 4, actual.count
    assert_equal 'Shopin1901', actual[0].name
  end

  def test_for_average_item_price_for_merchant
    actual = @sales_analyst.average_item_price_for_merchant(12_334_185)

    assert actual.is_a?(BigDecimal)
    assert_equal 0.1117e2, actual
  end

  def test_for_average_average_price_per_merchant
    actual = @sales_analyst.average_average_price_per_merchant

    assert actual.is_a?(BigDecimal)
    assert_equal 0.309e1, actual
  end

  def test_for_item_unit_prices
    expected = [0.12e2, 0.13e2, 0.135e2, 0.7e1, 0.15e2, 0.2999e2, 0.149e3,
                0.149e2, 0.69e1, 0.4e3, 0.13e3, 0.399e1, 0.8e2, 0.6e3, 0.65e3,
                0.4e2, 0.239e2, 0.5e3, 0.239e2, 0.5e3, 0.5e1, 0.2e1, 0.35e1, 0.406e3]
    actual = @sales_analyst.item_unit_prices

    assert_equal expected, actual
  end

  def test_for_average_item_price
    actual = @sales_analyst.average_item_price

    assert_equal 151.2325, actual
  end

  def test_for_item_price_standard_deviation
    actual = @sales_analyst.item_price_standard_deviation

    assert_equal 219.55, actual
  end

  def test_for_golden_items
    actual = @sales_analyst.golden_items

    assert actual.is_a?(Array)
    assert actual[0].is_a?(Item)
    assert_equal 'Introspection virginalle', actual[0].name
  end

  def test_for_average_invoices_per_merchant
    assert_equal 0.18, @sales_analyst.average_invoices_per_merchant
  end

  def test_for_average_invoices_per_merchant_standard_deviation
    actual = @sales_analyst.average_invoices_per_merchant_standard_deviation
    assert_equal 0.5, actual
  end

  def test_for_top_merchants_by_invoice_count
    actual = @sales_analyst.top_merchants_by_invoice_count

    assert actual.is_a?(Array)
    assert actual[0].is_a?(Merchant)
    assert_equal 1, actual.count
    assert_equal 'Candisart', actual[0].name
  end

  def test_for_bottom_merchants_by_invoice_count
    actual = @sales_analyst.bottom_merchants_by_invoice_count

    assert actual.is_a?(Array)
    assert actual.empty?
    assert_equal 0, actual.count
  end

  def test_top_days_by_invoice_count
    actual = @sales_analyst.top_days_by_invoice_count

    assert actual.is_a?(Array)
    assert actual[0].is_a?(String)
    assert_equal 1, actual.count
    assert_equal 'Friday', actual[0]
  end

  def test_for_invoice_status
    assert_equal 36.0, @sales_analyst.invoice_status(:pending)
    assert_equal 56.0, @sales_analyst.invoice_status(:shipped)
    assert_equal 8.0, @sales_analyst.invoice_status(:returned)
  end

  def test_top_buyers
    assert_equal 2, @sales_analyst.top_buyers(2).length
    assert_equal 5, @sales_analyst.top_buyers(3).first.id

    assert_equal 2, @sales_analyst.top_buyers.length
    assert_equal 339, @sales_analyst.top_buyers.last.id
  end

  def test_top_merchant_for_customer
    expected = @se.merchants.find_by_id(123_359_38)

    assert_equal expected, @sales_analyst.top_merchant_for_customer(1)
  end

  def test_one_time_buyers
    expected = @se.customers.find_by_id(5)

    assert_equal 2, @sales_analyst.one_time_buyers.length
    assert_equal expected, @sales_analyst.one_time_buyers.first
  end

  def test_one_time_buyers_top_items
    assert_equal 1, @sales_analyst.one_time_buyers_top_items.length
    assert_equal 263_504_126, @sales_analyst.one_time_buyers_top_items.first.id
  end

  def test_items_bought_in_year
    assert_equal 4, @sales_analyst.items_bought_in_year(1, 2012).length
    assert_equal 263_519_844, @sales_analyst.items_bought_in_year(1, 2009).first.id
  end

  def test_highest_volume_items
    assert_equal 2, @sales_analyst.highest_volume_items(1).length
    assert_equal 263_454_779, @sales_analyst.highest_volume_items(1).first.id
    assert_equal Item, @sales_analyst.highest_volume_items(1).first.class
  end

  def test_customers_with_unpaid_invoices
    assert_equal 6, @sales_analyst.customers_with_unpaid_invoices.length
    assert_equal 1, @sales_analyst.customers_with_unpaid_invoices.first.id
    assert_equal 339, @sales_analyst.customers_with_unpaid_invoices.last.id
  end

  def test_best_invoice_by_revenue
    assert_instance_of Invoice, @sales_analyst.best_invoice_by_revenue
    assert_equal 19, @sales_analyst.best_invoice_by_revenue.id
  end

  def test_best_invoice_by_quantity
    assert_instance_of Invoice, @sales_analyst.best_invoice_by_quantity
    assert_equal 19, @sales_analyst.best_invoice_by_quantity.id
  end
end
