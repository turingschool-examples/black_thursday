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
    assert_equal 11, merchants.count
  end

  def test_it_finds_average_items_per_merchant
    assert_equal 1.64, @sa.average_items_per_merchant
  end

  def test_it_finds_all_the_items
    items = @sa.items
    assert_equal 18, items.count
  end

  def test_it_finds_the_average_items_per_merchant_standard_deviation
    assert_equal 1.12, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_finds_the_merchants_with_the_highest_item_counts
    merchants = @sa.merchants_with_high_item_count

    assert_equal 3, merchants.count
  end

  def test_it_finds_average_item_price_for_merchant
    assert_equal 20.00, @sa.average_item_price_for_merchant(12334115)
  end

  def test_it_finds_average_average_price_per_merchant
    assert_equal 0.3125e2, @sa.average_average_price_per_merchant
  end

  def test_it_finds_golden_items
    golden_items = @sa.golden_items

    assert_equal 1, golden_items.count
  end

  def test_average_invoices_per_merchant_returns_average_invoices
    assert_equal 1.09, @sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation_returns_correct_value
    assert_equal 0.3, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_two_standard_deviations_above_average_invoices_returns_correct_value
    assert_equal 1.7, @sa.two_standard_deviations_above_average_invoices
  end

  def test_top_merchants_by_invoice_count_returns_merchants_with_highest_invoice_count
    merchants_with_high_invoice_count = @sa.top_merchants_by_invoice_count

    assert_equal 1, merchants_with_high_invoice_count.count
  end

  def test_two_standard_deviations_below_average_invoices_returns_correct_value
    assert_equal 0.5, @sa.two_standard_deviations_below_average_invoices
  end

  def test_bottom_merchants_by_invoice_count_returns_merchants_with_lowest_invoice_count
    merchants_with_lowest_invoice_count = @sa.bottom_merchants_by_invoice_count

    assert_equal 0, merchants_with_lowest_invoice_count.count
  end

  def test_average_invoices_created_per_weekday
    assert_equal 1.71, @sa.average_invoices_created_per_weekday
  end

  def test_average_invoices_created_per_weekday_standard_deviation
    assert_equal 1.55, @sa.average_invoices_created_per_weekday_standard_deviation
  end

  def test_one_standard_deviations_above_average_invoices_returns_correct_value
    assert_equal 3.26, @sa.one_standard_deviation_above_average_invoices_created_per_weekday
  end

  def test_top_days_by_invoice_count_returns_array_of_popular_days
    popular_days = @sa.top_days_by_invoice_count

    assert_equal ["Friday"], popular_days
  end

  def test_invoice_status_with_status_argument_returns_percentage_of_status
    assert_equal 58.33, @sa.invoice_status(:shipped)
    assert_equal 33.33, @sa.invoice_status(:pending)
    assert_equal 8.33, @sa.invoice_status(:returned)
  end

  def test_total_revenue_by_date_finds_total_revenue_on_a_given_date
    date = Time.parse("2010-09-17")
    assert_equal 8079.08, @sa.total_revenue_by_date(date)
  end
end
