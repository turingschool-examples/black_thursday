require './test/test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'
class TestSalesAnalyst < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      items:      "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:   "./data/invoices.csv",
      transactions: "./data/transactions.csv",
      invoice_items: "./data/invoice_items.csv"})

    @sales_analyst = SalesAnalyst.new(@sales_engine)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_finds_average_items_per_merchant
    assert_equal 2.88, @sales_analyst.average_items_per_merchant
    assert_instance_of Float, @sales_analyst.average_items_per_merchant
  end

  def test_it_item_count_of_all_merchants
    assert_equal 475, @sales_analyst.all_merchant_item_count.length
  end
  #
  def test_it_can_find_standard_deviation
    merchant_items = @sales_analyst.all_merchant_item_count.values
    assert_equal 3.26, @sales_analyst.average_items_per_merchant_standard_deviation
    assert_instance_of Float, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_can_find_high_merchant_items
    assert_equal 52, @sales_analyst.merchants_with_high_item_count.length
    assert_equal Merchant, @sales_analyst.merchants_with_high_item_count.first.class
  end

  def test_it_can_find_average_item_price_for_merchant
    merchant_id = 12334105
    assert_equal 16.66, @sales_analyst.average_item_price_for_merchant(merchant_id)
    assert_equal BigDecimal, @sales_analyst.average_item_price_for_merchant(merchant_id).class
  end

  def test_it_can_find_average_average_item_price_for_merchant
    assert_equal 350.29, @sales_analyst.average_average_price_per_merchant
    assert_equal BigDecimal, @sales_analyst.average_average_price_per_merchant.class
  end

  def test_it_can_find_average_invoices_per_merchant
    assert_equal 10.49, @sales_analyst.average_invoices_per_merchant
    assert_equal Float, @sales_analyst.average_invoices_per_merchant.class
  end

  def test_invoice_standard_dev
    assert_equal 3.29, @sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    assert_equal 12, @sales_analyst.top_merchants_by_invoice_count.length
    assert_equal Merchant, @sales_analyst.top_merchants_by_invoice_count.first.class
  end
  #
  def test_bottom_merchants_by_invoice_count
    assert_equal 4, @sales_analyst.bottom_merchants_by_invoice_count.length
    assert_equal Merchant, @sales_analyst.bottom_merchants_by_invoice_count.first.class
  end

  def test_average_invoices_per_day
    assert_equal 712.14, @sales_analyst.average_invoices_per_day
  end

  def test_standard_dev_invoices_per_day
    assert_equal 18.07, @sales_analyst.average_invoices_per_day_standard_deviation
  end

  def test_top_days_by_invoice_count
    assert_equal 1, @sales_analyst.top_days_by_invoice_count.length
    assert_equal "Wednesday", @sales_analyst.top_days_by_invoice_count.first
    assert_equal String, @sales_analyst.top_days_by_invoice_count.first.class
  end

  def test_percetage_status
    assert_equal 56.95, @sales_analyst.invoice_status(:shipped)
    assert_equal 29.55, @sales_analyst.invoice_status(:pending)
    assert_equal 13.5, @sales_analyst.invoice_status(:returned)
  end

  def test_it_finds_those_golden_items
    assert_equal 5, @sales_analyst.golden_items.length
    assert_equal Item, @sales_analyst.golden_items.first.class
  end

  def test_merchants_with_pending_invoices
    assert_equal 467, @sales_analyst.merchants_with_pending_invoices.count
  end

  def test_it_finds_merchants_with_only_one_item
    assert_equal 243, @sales_analyst.merchants_with_only_one_item.length
    assert_equal Merchant, @sales_analyst.merchants_with_only_one_item.first.class
  end

  def test_it_can_find_merchants_with_only_one_item_registered_in_month
    assert_equal 18, @sales_analyst.merchants_with_only_one_item_registered_in_month("June").length
    assert_equal Merchant, @sales_analyst.merchants_with_only_one_item_registered_in_month("June").first.class
  end

  # def test_it_returns_revenue_for_given_merchant
  #   expected = @sales_analyst.revenue_by_merchant(12334194)

  #   assert_equal BigDecimal.new(expected), expected
  #   assert_equal BigDecimal, expected
  # end

  def test_invoice_paid_in_full
    assert_equal true, @sales_analyst.invoice_paid_in_full?(1)
    assert_equal true, @sales_analyst.invoice_paid_in_full?(200)
    assert_equal false, @sales_analyst.invoice_paid_in_full?(203)
    assert_equal false, @sales_analyst.invoice_paid_in_full?(204)
  end

  def test_total_revenue_by_date
    date = Time.parse("2009-02-07")
    assert_equal 21067.77, @sales_analyst.total_revenue_by_date(date)
    assert_equal BigDecimal, @sales_analyst.total_revenue_by_date("2009-02-07").class
  end

  def test_top_revenue_earners
    assert_equal Merchant, @sales_analyst.top_revenue_earners.first.class
    assert_equal 12334634, @sales_analyst.top_revenue_earners.first.id
    assert_equal Merchant, @sales_analyst.top_revenue_earners.first.class
    assert_equal 12335747, @sales_analyst.top_revenue_earners.last.id
  end

  def test_top_revenue_by_merchant
    assert_equal 1, @sales_analyst.revenue_by_merchant(12334194)
  end
end
