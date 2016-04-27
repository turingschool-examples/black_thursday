require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < MiniTest::Test
  attr_reader :sa

  def setup
    se = SalesEngine.from_csv({
      :items     => "./test/test_csvs/items_test.csv",
      :merchants => "./test/test_csvs/merchants_test.csv",
      :invoices => "./test/test_csvs/invoices_test.csv",
      :invoice_items => "./test/test_csvs/invoice_items_test.csv",
      :transactions => "./test/test_csvs/transactions_test.csv",
      :customers => "./test/test_csvs/customers_test.csv",
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_it_itializes_sales_analyst
    assert sa
  end

  def test_it_finds_number_of_items_for_each_merchant
    assert_equal 49, sa.items_per_merchant.length
  end

  def test_it_finds_average_items_per_merchant
    assert_equal 0.57, sa.average_items_per_merchant
  end

  def test_it_finds_standard_deviation
    assert_equal 2.19, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_finds_merchants_with_high_item_count
    assert_equal 3, sa.merchants_with_high_item_count.count
  end

  def test_it_returns_merchants_all_in_an_array_with_their_item_count
    assert_equal 49, sa.merchants_with_item_counts.count
  end

  def test_it_makes_average_merchant_unit_price_for_one_item
    assert_equal 30.03, sa.average_item_price_for_merchant(12334113).to_f
  end

  def test_it_can_average_item_prices_of_multiple_items
    assert_equal 30.03, sa.average_item_price_for_merchant(12334113).to_f
  end

  def test_it_finds_average_average_item_price_for_merchant
    assert_equal 1.04, sa.average_average_price_per_merchant.to_f
  end

  def test_it_finds_all_items_unit_prices
    assert_equal 28, sa.all_items_unit_prices.count
  end

  def test_it_finds_average_items_price
    assert_equal 12.31, sa.average_items_price.to_f.round(2)
  end

  def test_it_finds_items_price_standard_deviation
    assert_equal 37.02, sa.items_price_standard_deviation.to_f.round(2)
  end

  def test_it_finds_golden_items
    assert_equal 1, sa.golden_items.count
  end

  def test_it_finds_average_invoices_per_merchant
    assert_equal 0.16, sa.average_invoices_per_merchant
  end

  def test_it_finds_top_merchants_by_invoice_count
    assert_equal 2, sa.top_merchants_by_invoice_count.count
  end

  def test_it_finds_bottom_merchants_by_invoice_count
    assert_equal 0, sa.bottom_merchants_by_invoice_count.count
  end

  def test_it_finds_invoices_by_day
    assert sa.days_with_invoices
  end

  def test_it_counts_invoices_per_day
    assert_equal ({"Saturday"=>8}), sa.days_with_count[0]
  end

  def test_it_counts_invoices_per_day_small_data_set
    assert_equal ({"Thursday"=>7}), sa.days_with_count[-1]
  end

  def test_it_finds_invoices_by_week_day_small_data_set
    assert_equal [8, 12, 1, 8, 5, 9, 7],  sa.invoices_by_day
  end

  def test_it_finds_average_invoices_per_week_day
    assert_equal 7,  sa.invoices_by_day_average
  end

  def test_it_finds_top_days
    assert_equal ["Friday"], sa.top_days_by_invoice_count
  end

  def test_it_returns_invoice_status_pending
    assert_equal 34, sa.invoice_status(:pending)
  end

  def test_it_returns_invoice_status_shipped
    assert_equal 60, sa.invoice_status(:shipped)
  end

  def test_it_finds_total_revenue_by_date_when_all_dates_included
    assert_equal 2117477, sa.total_revenue_by_date(Time.parse("2009-02-07")).to_f * 100
  end

  def test_it_finds_merchants_with_pending_invoices
    assert_equal 3, sa.merchants_with_pending_invoices.length
  end

  def test_it_finds_merchants_with_one_item
    assert_equal 0, sa.merchants_with_only_one_item.length
  end

  def test_it_finds_most_sold_items_for_merchant
    assert_equal [], sa.most_sold_item_for_merchant(12334155)
  end

  def test_it_finds_most_sold_items_for_a_different_merchant
    assert_equal 2, sa.most_sold_item_for_merchant(12334105).length
  end

  def test_it_finds_best_item_for_merchant_with_no_paid_items
    assert_equal nil, sa.best_item_for_merchant(12334113)
  end

  def test_it_can_find_revenue_of_a_given_merchant
    assert_equal 1964.05, sa.revenue_by_merchant(12334113).to_f
  end

  def test_it_creates_a_hash_of_merchants_and_their_revenues
    assert_equal "Shopin1901", sa.merchant_revenues[0][:merchant].name
  end

  def test_it_sorts_merchants_by_their_revenue_low_to_high
    assert_equal 0, sa.ranked_merchants[0][:revenue]
    assert_equal 30158.61, sa.ranked_merchants[-1][:revenue].to_f
  end

  def test_it_can_rank_merchants_by_their_revenue
    assert_equal "Candisart", sa.merchants_ranked_by_revenue[0].name
  end

  def test_it_takes_twenty_top_revenue_earners_by_default
    assert_equal 20, sa.top_revenue_earners.count
  end

  def test_it_can_be_passed_how_many_top_revenue_earners_desired
    assert_equal 5, sa.top_revenue_earners(5).count
  end

  def test_it_can_return_merchants_created_in_a_specific_month
    assert_equal 7, sa.merchants_created_in_month("March").count
  end

  def test_the_months_taken_are_very_case_insensitive
    assert_equal 7, sa.merchants_created_in_month("mArCh").count
  end

  def test_it_can_find_the_merchants_that_have_one_item_registered_in_a_month
    assert_equal 0, sa.merchants_with_only_one_item_registered_in_month("March").count
  end
end
