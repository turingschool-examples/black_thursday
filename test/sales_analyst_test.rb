require_relative 'test_helper.rb'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < MiniTest::Test
  def setup
    se = SalesEngine.from_csv({
      items:     './test/fixtures/items_truncated.csv',
      merchants: './test/fixtures/merchants_truncated.csv',
      invoices:  './test/fixtures/invoices_truncated.csv',
      invoice_items: './test/fixtures/invoice_items_truncated.csv',
      transactions: './test/fixtures/transactions_truncated.csv',
      customers: './test/fixtures/customers_truncated.csv'
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_it_finds_all_the_merchants
    merchants = @sa.merchants
    assert_equal 21, merchants.count
  end

  def test_it_finds_average_items_per_merchant
    assert_equal 1.62, @sa.average_items_per_merchant
  end

  def test_it_finds_all_the_items
    items = @sa.items
    assert_equal 34, items.count
  end

  def test_it_finds_the_average_items_per_merchant_stdev
    assert_equal 1.64, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_finds_the_merchants_with_the_highest_item_counts
    merchants = @sa.merchants_with_high_item_count

    assert_equal 3, merchants.count
  end

  def test_it_finds_average_item_price_for_merchant
    assert_equal 20.00, @sa.average_item_price_for_merchant(12334115)
  end

  def test_it_finds_average_average_price_per_merchant
    assert_equal 30.98, @sa.average_average_price_per_merchant
  end

  def test_it_finds_golden_items
    golden_items = @sa.golden_items

    assert_equal 2, golden_items.count
  end

  def test_average_invoices_per_merchant_returns_average_invoices
    assert_equal 1.29, @sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_stdev_returns_correct_value
    assert_equal 0.72, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_two_stdevs_above_average_invoices_returns_correct_value
    assert_equal 2.7, @sa.two_stdevs_above_average_invoices
  end

  def test_top_merchants_by_invoice_count_returns_merchants_with_highest_invoice_count
    merchants_with_high_invoice_count = @sa.top_merchants_by_invoice_count

    assert_equal 1, merchants_with_high_invoice_count.count
  end

  def test_two_stdevs_below_average_invoices_returns_correct_value
    assert_equal (-0.1), @sa.two_stdevs_below_average_invoices
  end

  def test_bottom_merchants_by_invoice_count_returns_merchants_with_lowest_invoice_count
    merchants_with_lowest_invoice_count = @sa.bottom_merchants_by_invoice_count

    assert_equal 0, merchants_with_lowest_invoice_count.count
  end

  def test_average_invoices_per_weekday
    assert_equal 3.57, @sa.average_invoices_per_weekday
  end

  def test_average_invoices_per_weekday_stdev
    assert_equal 1.47, @sa.average_invoices_per_weekday_stdev
  end

  def test_one_standard_deviations_above_average_invoices_returns_correct_value
    assert_equal 5.04, @sa.one_stdev_above_average_invoices_per_weekday
  end

  def test_top_days_by_invoice_count_returns_array_of_popular_days
    popular_days = @sa.top_days_by_invoice_count

    assert_equal ["Friday"], popular_days
  end

  def test_invoice_status_returns_percentage_of_given_status
    assert_equal 68.00, @sa.invoice_status(:shipped)
    assert_equal 24.00, @sa.invoice_status(:pending)
    assert_equal 8.00, @sa.invoice_status(:returned)
  end

  def test_total_revenue_by_date_finds_total_revenue_on_a_given_date
    date = Time.parse("2010-09-17")
    assert_equal 6325.69, @sa.total_revenue_by_date(date)
  end

  def test_top_revenue_earners_returns_given_number_of_merchants_with_highest_revenue
    merchants = @sa.top_revenue_earners(2)

    assert_equal 2, merchants.count
    top_two_revenues = merchants.map do |merchant|
      merchant.revenue
    end
    assert_equal [0.4792194e5, 0.2977622e5], top_two_revenues
  end

  def test_top_revenue_earners_returns_20_merchants_by_default
    merchants = @sa.top_revenue_earners

    assert_equal 20, merchants.count
  end

  def test_it_returns_all_merchants_that_have_pending_invoices
    merchants = @sa.merchants_with_pending_invoices

    assert_equal 1, merchants.count

    all_pending = merchants.all? do |merchant|
      merchant.pending_invoices?
    end

    assert all_pending
  end

  def test_it_returns_all_merchants_ranked_by_revenue
    merchants = @sa.merchants_ranked_by_revenue

    assert_equal 21, merchants.count
    assert_equal 47921.94, merchants.first.revenue
    assert_equal 0, merchants.last.revenue
  end

  def test_it_returns_all_merchants_with_only_one_item
    merchants = @sa.merchants_with_only_one_item
    all_have_only_one = merchants.all? do |merchant|
      merchant.items.count == 1
    end

    assert all_have_only_one
    assert_equal 14,  merchants.count
  end

  def test_it_returns_all_merchants_with_only_one_item_registered_in_given_month
    month = "january"
    merchants = @sa.merchants_with_only_one_item_registered_in_month(month)

    assert_equal 3, merchants.count
    assert_equal 1, merchants.first.items.count
    assert_equal month, merchants.first.month_registered
  end

  def test_revenue_by_merchant_finds_revenue_for_merchant_with_given_id
    assert_equal 307.30, @sa.revenue_by_merchant(12334132)
    assert_equal 3836.16, @sa.revenue_by_merchant(12334144)
  end

  def test_most_sold_item_for_merchant_returns_most_sold_items
    assert_equal 1, @sa.most_sold_item_for_merchant(12334105).count
  end

  def test_best_item_for_merchant_returns_item_with_most_revenue
    assert_instance_of Item, @sa.best_item_for_merchant(12334105)
  end
end
