require './test/test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup

    @sales_engine = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
      })
    @sales_analyst = @sales_engine.analyst

  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_returns_avg_items_per_merchant
    assert_equal 2.88, @sales_analyst.average_items_per_merchant
  end

  def test_it_returns_merchant_item_list
    merchant = @sales_analyst.merchants[4]
    item_list = @sales_analyst.merchant_item_list(merchant)
    assert_equal 25, item_list.count
  end

  def test_avg_items_per_merchant_std_dev
    std_dev = @sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal 3.26, std_dev
  end

  def test_merchants_with_high_item_count
    hicmerchs = @sales_analyst.merchants_with_high_item_count
    assert_instance_of Array, hicmerchs
    assert_equal 52, hicmerchs.count
  end

  def test_avg_price_for_a_merchant
    actual = @sales_analyst.average_item_price_for_merchant(12334159)
    assert_instance_of BigDecimal, actual
    assert_equal 31.50, actual.to_f.round(2)
  end

  def test_avg_avg_price_per_merchant
    actual = @sales_analyst.average_average_price_per_merchant
    assert_instance_of BigDecimal, actual
    assert_equal 350.29, actual.to_f.round(2)
  end

  def test_avg_item_price
    actual = @sales_analyst.average_item_price
    assert_instance_of BigDecimal, actual
    assert_equal 251.06, actual.to_f.round(2)
  end

  def test_avg_item_price_std_dev
    actual = @sales_analyst.average_item_price_std_dev
    assert_instance_of BigDecimal, actual
    assert_equal 2900.99, actual.to_f.round(2)
  end

  def test_golden_items
    actual = @sales_analyst.golden_items
    assert_instance_of Array, actual
    assert_equal 5, actual.count
  end

  def test_average_invoices_per_merchant
    actual = @sales_analyst.average_invoices_per_merchant
    assert_equal 10.49, actual
  end

  def test_it_returns_merchant_invoice_list
    merchant = @sales_analyst.merchants[4]
    invoice_list = @sales_analyst.merchant_invoice_list(merchant)
    assert_equal 10, invoice_list.count
  end

  def test_average_invoices_per_merchant_standard_deviation
    actual = @sales_analyst.average_invoices_per_merchant_standard_deviation
    assert_equal 3.29, actual
  end

  def test_top_merchants_by_invoice_count
    actual = @sales_analyst.top_merchants_by_invoice_count.count
    assert_equal  12, actual
  end

  def test_bottom_merchants_by_invoice_count
    actual = @sales_analyst.bottom_merchants_by_invoice_count.count
    assert_equal  4, actual
  end

  def test_top_days_by_invoice_count
    skip
    actual = @sales_analyst.top_days_by_invoice_count
    assert_equal ["Wednesday"], actual
  end

  def test_invoice_status
    actual = @sales_analyst.invoice_status(:pending)
    assert_equal 29.55, actual

    actual = @sales_analyst.invoice_status(:shipped)
    assert_equal 56.95, actual

    actual = @sales_analyst.invoice_status(:returned)
    assert_equal 13.5, actual
  end

  def test_it_can_return_the_invoices_paid_in_full
  skip
    actual = @sales_analyst.invoice_paid_in_full?(46)
    assert actual
    actual_2 = @sales_analyst.invoice_paid_in_full?(1752)
    refute actual_2
  end

  def test_it_can_return_the_total_amount_of_the_invoice
    actual = @sales_analyst.invoice_total(1)
    assert_equal 21_067.77, actual
    assert_instance_of BigDecimal, actual
  end

  def test_it_can_get_total_revenue_by_date
    date = Time.parse("2009-02-07")
    actual = @sales_analyst.total_revenue_by_date(date)
    assert_instance_of BigDecimal, actual
    assert_equal 21_067.77, actual
  end

  def test_can_get_revenue_for_each_merchant
    actual = @sales_analyst.merchant_revenue(12335938)
    assert_equal BigDecimal(126300.9, 7), actual
  end

  def test_it_can_get_the_top_revenue_earners_for_merchants
   actual = @sales_analyst.top_revenue_earners(20)
   assert_instance_of Merchant, actual.first
   assert_equal 20, actual.length
  end

  def test_it_can_get_merchants_with_pending_invoices
   actual = @sales_analyst.merchants_with_pending_invoices
   assert_instance_of Merchant, actual.first
   assert_equal 467, actual.length
  end

end
