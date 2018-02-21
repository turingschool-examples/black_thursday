require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

# This is a class for tests of the sales analyst class.
class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(
      items:     './test/fixtures/items_list_truncated.csv',
      merchants: './test/fixtures/merchants_list_truncated.csv',
      invoices:  './test/fixtures/invoices_list_truncated.csv'
    )
    @sales_analyst = SalesAnalyst.new(@se)
  end

  def test_it_exists_and_sales_engine_argument
    assert_instance_of SalesAnalyst, @sales_analyst
    assert_equal @se, @sales_analyst.sales_engine
  end

  def test_for_items_per_merchant
    expected = [1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0]
    actual = @sales_analyst.items_per_merchant
    assert_equal expected, actual
  end

  def test_for_average_items_per_merchant
    assert_equal 0.29, @sales_analyst.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    actual = @sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal 0.72, actual
  end

  def test_merchants_with_high_item_count
    actual = @sales_analyst.merchants_with_high_item_count

    assert actual.is_a?(Array)
    assert actual[0].is_a?(Merchant)
    assert_equal 1, actual.count
    assert_equal 'Madewithgitterxx', actual[0].name
  end

  def test_for_average_item_price_for_merchant
    actual = @sales_analyst.average_item_price_for_merchant(12_334_185)

    assert actual.is_a?(BigDecimal)
    assert_equal 0.1117e2, actual
  end

  def test_for_average_average_price_per_merchant
    actual = @sales_analyst.average_average_price_per_merchant

    assert actual.is_a?(BigDecimal)
    assert_equal 0.324e1, actual
  end

  def test_for_item_unit_prices
    expected = [0.12e2, 0.13e2, 0.135e2, 0.7e1, 0.15e2, 0.2999e2,
                0.149e3, 0.149e2, 0.69e1, 0.4e3, 0.13e3, 0.399e1,
                0.8e2, 0.6e3, 0.65e3, 0.4e2, 0.239e2, 0.5e3, 0.239e2,
                0.5e3]
    actual = @sales_analyst.item_unit_prices

    assert_equal expected, actual
  end

  def test_for_average_item_price
    actual = @sales_analyst.average_item_price

    assert_equal 160.654, actual
  end

  def test_for_item_price_standard_deviation
    actual = @sales_analyst.item_price_standard_deviation

    assert_equal 226.7, actual
  end

  def test_for_golden_items
    actual = @sales_analyst.golden_items

    assert actual.is_a?(Array)
    assert actual[0].is_a?(Item)
    assert_equal 'La prière', actual[0].name
  end

  def test_for_average_invoices_per_merchant
    assert_equal 0.14, @sales_analyst.average_invoices_per_merchant
  end

  def test_for_average_invoices_per_merchant_standard_deviation
    actual = @sales_analyst.average_invoices_per_merchant_standard_deviation
    assert_equal 0.48, actual
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
    assert_equal 2, actual.count
    assert_equal 'Friday', actual[0]
  end

  def test_for_invoice_status
    assert_equal 40.91, @sales_analyst.invoice_status(:pending)
    assert_equal 50.0, @sales_analyst.invoice_status(:shipped)
    assert_equal 9.09, @sales_analyst.invoice_status(:returned)
  end
end
