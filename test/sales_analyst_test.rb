require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/sales_analyst"

class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/support/merchant_support.csv",
      invoices: "./data/support/invoices_support.csv",
      transactions: "./data/support/transactions_support.csv",
      invoice_items: "./data/support/invoice_items_support.csv"
      })
    @sa = SalesAnalyst.new(@se)
  end
  def test_it_can_calculate_average_items_per_merchant
    assert_equal 13.67, @sa.average_items_per_merchant
  end

  def test_we_have_standard_deviation
    assert_equal 11.17, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_find_merchants_with_most_items
    assert_equal 1, @sa.merchants_with_high_item_count.count
  end

  def test_it_can_find_the_average_price_for_a_merchant_with_one_item
    assert_equal 49.95, @sa.average_item_price_for_merchant(12334303).to_f
  end

  def test_it_can_find_the_average_price_for_a_merchant_with_multiple_items
    assert_equal 483.35, @sa.average_item_price_for_merchant(12334195).to_f
  end

  def test_average_of_average_price_per_merchant
    assert_equal 1104.85, @sa.average_average_price_per_merchant.to_f
  end

  def test_it_finds_golden_items
    assert_equal 5, @sa.golden_items.count
  end

  def test_it_finds_average_invoices_per_merchant
    assert_equal 2.01, @sa.average_invoices_per_merchant
  end

  def test_it_finds_standard_deviation_for_invoice_per_merchant
    assert_equal 1.73, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_it_finds_top_merchants_by_invoice_count
    assert_equal 0, @sa.top_merchants_by_invoice_count.count
  end

  def test_it_finds_bottom_merchants_by_invoice_count
    assert_equal 0, @sa.bottom_merchants_by_invoice_count.count
  end

  def test_it_finds_best_days_by_invoice_count
    assert_equal ["Saturday", "Friday"], @sa.top_days_by_invoice_count
  end

  def test_it_calculates_invoice_status_ratios
    assert_equal 58.71, @sa.invoice_status(:shipped)
  end

  def test_it_can_get_revenue_total_for_a_merchant
    assert_equal 22496.84, SalesAnalyst.new(@se).revenue_by_merchant(12335150)
  end

  def test_it_can_find_all_invoices_for_given_date
    assert_equal 22496.84, SalesAnalyst.new(@se).total_revenue_by_date(Time.parse"2005-12-19")
  end

  def test_it_can_find_top_earners
    assert_equal 12334195, SalesAnalyst.new(@se).top_revenue_earners.first.id
    assert_equal 12334195, SalesAnalyst.new(@se).top_revenue_earners(10).first.id
  end

  def test_it_can_find_merchants_with_pending_invoices
    assert_equal 33, SalesAnalyst.new(@se).merchants_with_pending_invoices.count
  end

  def test_it_can_find_merchants_with_one_item
    assert_equal 46, SalesAnalyst.new(@se).merchants_with_only_one_item.count
  end

  def test_it_can_find_merchants_with_one_item_for_given_month
    assert_equal 3, SalesAnalyst.new(@se).merchants_with_only_one_item_registered_in_month("September").count
  end

  def test_it_can_find_most_sold_item_for_given_merchant
    assert_equal "", SalesAnalyst.new(@se).most_sold_item_for_merchant(12335150).first.id
  end

end
