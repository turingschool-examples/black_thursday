require 'minitest/autorun'
require 'minitest/emoji'
require 'csv'
require 'bigdecimal'
require_relative '../lib/sales_analyst'
require_relative "../test/test_helper"

class SalesAnalystTest < Minitest::Test
  attr_reader :sales_engine
  def setup
    @sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/small_merchant_file.csv",
      :invoices => "./data/small_invoice_file.csv",
      :customers => "./data/small_customer_file.csv",
      :transactions => "./data/small_transaction_file.csv",
      :invoice_items => "./data/small_invoice_item_file.csv"})
  end

  def test_it_exists
    sa = SalesAnalyst.new(sales_engine)
    assert_equal SalesAnalyst, sa.class
  end

  def test_it_connects_with_sales_engine
    sa = SalesAnalyst.new(sales_engine)
    assert_equal Class, sa.se.class
  end

  def test_standard_deviation_works_on_an_array
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 1.0, sa.standard_deviation([1,2,3])
    assert_equal 2.65, sa.standard_deviation([1,2,6])
  end

  def test_generates_array_of_item_counts_per_merchant
    sa = SalesAnalyst.new(sales_engine)
    assert_equal  [3, 5, 1, 6, 25, 20, 1, 1, 1, 3], sa.items_per_merchant
  end

  def test_it_can_find_average_items_per_merchant
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 136.7, sa.average_items_per_merchant
  end

  def test_it_creates_all_merchant_ids
    sa = SalesAnalyst.new(sales_engine)
    result = sa.create_all_merchant_ids
    assert_equal 10, result.length
  end

  def test_it_can_find_average_item_price_for_merchant
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 100.0, sa.average_item_price_for_merchant(12334123)
  end

  def test_it_can_find_items_per_merchant_standard_deviation
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 8.64, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_find_average_item_price_for_all_merchants
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 91.54, sa.average_average_price_per_merchant.to_f
  end

  def test_it_can_find_merchants_with_high_item_count
    sa = SalesAnalyst.new(sales_engine)
    assert_equal "Keckenbauer", sa.merchants_with_high_item_count.first.name
  end

  def test_it_can_find_golden_items
    sa = SalesAnalyst.new(sales_engine)
    assert_equal "Test listing", sa.golden_items.first.name
  end

  def test_it_can_find_average_invoices_per_merchant
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 111.6, sa.average_invoices_per_merchant
  end

  def test_it_can_find_invoices_per_merchant_standard_deviation
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 1.16, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_it_can_find_invoice_status
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 29.3, sa.invoice_status("pending".to_sym)
    assert_equal 56.45, sa.invoice_status("shipped".to_sym)
    assert_equal 14.25, sa.invoice_status("returned".to_sym)
  end

  def test_it_can_find_top_merchants_by_invoice_count
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 0, sa.top_merchants_by_invoice_count.length
  end

  def test_it_can_find_bottom_merchants_by_invoice_count
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 0, sa.bottom_merchants_by_invoice_count.length
  end

  def test_it_can_group_invoices_by_day
    sa = SalesAnalyst.new(sales_engine)
    assert_equal ["Tuesday", "Sunday", "Saturday", "Wednesday", "Thursday", "Monday", "Friday"], sa.group_invoices_by_day.keys
  end

  def test_it_can_find_invoice_count_by_day_array
    sa = SalesAnalyst.new(sales_engine)
    assert_equal [], sa.invoices_count_by_day
  end

  def test_it_can_find_top_days_by_invoice_count
    sa = SalesAnalyst.new(sales_engine)
    assert_equal [], sa.top_days_by_invoice_count
  end

  def test_it_can_find_total_revenue_by_date
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 5795.92, sa.total_revenue_by_date("2012-03-27").to_f
  end

  def test_it_can_find_top_revenue_earners_without_number_specified
    sa = SalesAnalyst.new(sales_engine)
    assert_equal "BowlsByChris", sa.top_revenue_earners.first.name
    assert_equal "Shopin1901", sa.top_revenue_earners.last.name
  end

  def test_it_can_find_top_revenue_earners_with_number_specified
    sa = SalesAnalyst.new(sales_engine)
    assert_equal "BowlsByChris", sa.top_revenue_earners(5).first.name
    assert_equal "perlesemoi", sa.top_revenue_earners(5).last.name
  end

  def test_it_can_find_merchants_with_pending_invoices
    sa = SalesAnalyst.new(sales_engine)
    assert_equal "Shopin1901", sa.merchants_with_pending_invoices.first.name
  end

  def test_it_can_find_merchants_with_only_one_item
    sa = SalesAnalyst.new(sales_engine)
    assert_equal "Urcase17", sa.merchants_with_only_one_item.last.name
  end

  def test_it_can_find_merchants_with_only_one_item_registered_in_month
    sa = SalesAnalyst.new(sales_engine)
    assert_equal "MiniatureBikez", sa.merchants_with_only_one_item_registered_in_month("March").first.name
  end  

  def test_it_can_find_revenue_by_merchant
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 0, sa.revenue_by_merchant(12334185)
  end

  def test_it_can_find_merchants_ranked_by_revenue
    sa = SalesAnalyst.new(sales_engine)
    assert_equal "BowlsByChris", sa.merchants_ranked_by_revenue.first.name
  end

  def test_it_can_find_most_sold_item_for_merchant
    sa = SalesAnalyst.new(sales_engine)
    assert_equal "Camicetta in pura seta con ricamo", sa.most_sold_item_for_merchant(12334132).first.name
  end

  def test_it_can_find_best_item_for_merchant
    sa = SalesAnalyst.new(sales_engine)
    assert_equal "Camicetta in pura seta con ricamo", sa.best_item_for_merchant(12334132).name
    assert_equal 30.0, sa.best_item_for_merchant(12334132).unit_price.to_f
  end


end