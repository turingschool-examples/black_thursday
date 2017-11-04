require_relative './test_helper'
require 'bigdecimal'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  attr_reader :se,
              :sa

  def setup
    @se = SalesEngine.from_csv({
      :items => "./test/fixture/item_truncated.csv",
      :merchants => './test/fixture/merchants_truncated.csv',
      :invoices => './test/fixture/invoice_truncated.csv',
      :customers => './test/fixture/customer_truncated.csv',
      :invoice_items => './test/fixture/invoice_item_truncated.csv',
      :transactions => './test/fixture/transactions_truncated.csv'
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_initialize_sales_analyst
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_can_determine_average_items_per_merchant
    assert_equal 1.6, sa.average_items_per_merchant
  end

  def test_it_can_determine_standard_deviation_items_per_merchant

    assert_equal 1.34, sa.average_items_per_merchant_standard_deviation
  end

  def test_determine_merchants_with_most_items
    result = sa.merchants_with_high_item_count

    assert_equal "Madewithgitterxx", result[0].name
  end

  def test_determines_average_price_for_merchants
    result = sa.average_item_price_for_merchant(12334185)
    assert_equal 184.63, result
  end

  def test_determines_average_average_price_per_merchants
    result = sa.average_average_price_per_merchant

    assert_equal BigDecimal(8893)/100, result
  end

  def test_it_can_determine_standard_deviation_items_price
    result = sa.standard_deviation_of_item_price

    assert_equal BigDecimal(23745)/100, result
  end

  def test_it_can_determine_the_golden_items
    result = sa.golden_items
    assert_equal 1, result.count
    assert_equal 'Free standing Woden letters', result[0].name
  end

  def test_average_invoices_per_merchant
    result = sa.average_invoices_per_merchant

    assert_equal 4.0, result
  end

  def test_top_merchants_by_invoice_count
    result = sa.top_merchants_by_invoice_count

    assert_equal 0, result.count
  end

  def test_bottom_merchants_by_invoice_count
    result = sa.bottom_merchants_by_invoice_count

    assert_equal 0, result.count
  end

  def test_top_days_by_invoice_count
    result = sa.top_days_by_invoice_count

    assert_equal ['Wednesday'], result
  end

  def test_invoice_count_by_day
    result = sa.invoice_count_by_day

    assert_equal 4, result.count
  end

  def test_standard_deviation_of_invoices_per_day
    result = sa.standard_deviation_of_invoices_per_day

    assert_equal 3.32, result
  end

  def test_precentage_of_invoice_status
    pending = sa.invoice_status(:pending)
    shipped = sa.invoice_status(:shipped)
    returned = sa.invoice_status(:returned)

    assert_equal 15.00, pending
    assert_equal 75.00, shipped
    assert_equal 10.00, returned
  end
end
