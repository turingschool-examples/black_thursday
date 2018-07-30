require_relative 'test_helper'
require_relative '../lib/sales_analyst.rb'
require_relative '../lib/sales_engine.rb'

class SalesAnalystTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
      })
    @sales_analyst = @sales_engine.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_can_average_items_per_merchant
    expected = 2.88
    actual = @sales_analyst.average_items_per_merchant

    assert_equal expected, actual
  end

  def test_it_can_find_stddev_of_average_items_per_merchant
    expected = 3.26
    actual = @sales_analyst.average_items_per_merchant_standard_deviation

    assert_equal expected, actual
  end

  def test_which_merchants_exceed_1_stdev_higher_than_average_number_products
    expected = 52
    actual = @sales_analyst.merchants_with_high_item_count.count

    assert_equal expected, actual
  end

  def test_it_can_find_average_item_price_for_merchant
    expected = 16.66
    actual = @sales_analyst.average_item_price_for_merchant(12334105)

    assert_equal expected, actual
  end

  def test_it_can_find_average_average_price_for_merchant
    expected = 350.29
    actual = @sales_analyst.average_average_price_per_merchant

    assert_equal expected, actual
  end

  def test_it_can_find_golden_items
    expected = 5
    actual = @sales_analyst.golden_items.count

    assert_equal expected, actual
  end

  def test_it_can_find_average_invoices_per_merchant
    expected = 10.49
    actual = @sales_analyst.average_invoices_per_merchant

    assert_equal expected, actual
  end

  def test_it_can_find_stddev_of_average_items_per_merchant
    expected = 3.29
    actual = @sales_analyst.average_invoices_per_merchant_standard_deviation

    assert_equal expected, actual
  end

  def test_it_can_find_top_merchants_by_invoice_count
    expected = 12
    actual = @sales_analyst.top_merchants_by_invoice_count

    assert_instance_of Merchant, actual[0]
    assert_equal expected, actual.count
  end

  def test_it_can_find_bottom_merchants_by_invoice_count
    expected = 4
    actual = @sales_analyst.bottom_merchants_by_invoice_count

    assert_instance_of Merchant, actual[0]
    assert_equal expected, actual.count
  end

  def test_it_can_find_top_days_by_invoice_count
    expected = ["Wednesday"]
    actual = @sales_analyst.top_days_by_invoice_count
    assert_equal expected, actual
  end

  def test_it_can_show_invoice_status_percentage
    expected = 29.55
    actual = @sales_analyst.invoice_status(:pending)

    assert_equal expected, actual

    expected_2 = 56.95
    actual_2 = @sales_analyst.invoice_status(:shipped)

    assert_equal expected_2, actual_2

    expected_3 = 13.5
    actual_3 = @sales_analyst.invoice_status(:returned)

    assert_equal expected_3, actual_3
  end

  def test_it_checks_if_invoice_paid_in_full
    assert_equal true, @sales_analyst.invoice_paid_in_full?(1)
    assert_equal false, @sales_analyst.invoice_paid_in_full?(204)
    assert_equal false, @sales_analyst.invoice_paid_in_full?(203)
  end

  def test_it_can_return_invoice_total
    assert_equal 21067.77, @sales_analyst.invoice_total(1)
  end

  def test_it_can_check_total_revenue_by_date
    assert_equal 14074.79, @sales_analyst.total_revenue_by_date(Time.parse("2011-06-30"))
  end

  def test_it_can_check_revenue_by_merchant
    assert_equal 81572, @sales_analyst.revenue_by_merchant(12334194).to_i
  end

  def test_it_can_check_top_revenue_earners_with_argument
    top_revenue_merchants = @sales_analyst.top_revenue_earners(10)
    assert_equal 10, @sales_analyst.top_revenue_earners(10).count
    assert_instance_of Merchant, top_revenue_merchants[0]
    assert_equal 12334634, @sales_analyst.top_revenue_earners(10).first.id
    assert_equal 12335747, @sales_analyst.top_revenue_earners(10).last.id

    assert_equal 20, @sales_analyst.top_revenue_earners.count
    assert_equal 12334634, @sales_analyst.top_revenue_earners.first.id
    assert_equal 12334159, @sales_analyst.top_revenue_earners.last.id
  end

  def test_it_can_rank_all_revenue_earners
    ranked_revenue_merchants = @sales_analyst.merchants_ranked_by_revenue
    assert_equal 475, @sales_analyst.merchants_ranked_by_revenue.count
    assert_equal 12334634, @sales_analyst.merchants_ranked_by_revenue.first.id
    assert_equal 12336175, @sales_analyst.merchants_ranked_by_revenue.last.id
    assert_instance_of Merchant, ranked_revenue_merchants[0]
  end

  def test_it_can_get_merchants_with_pending_invoices
    skip
    actual = @sales_analyst.merchants_with_pending_invoices
    assert_instance_of Merchant, actual[0]
    assert_equal 448, actual.count
  end

end
