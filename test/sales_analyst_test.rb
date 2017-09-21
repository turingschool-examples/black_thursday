require 'bigdecimal'
require 'time'

require './test/test_helper'
require './lib/sales_analyst'


class SalesAnalystTest < Minitest::Test

  attr_reader :sales_engine, :sales_analyst
  def setup
    @sales_engine = Fixture.sales_engine(load_full_data: true)
    @sales_analyst = SalesAnalyst.new(sales_engine)
  end

  def test_an_instance_exists_and_takes_sales_engine
    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_average_items_per_merchant_returns_float
    average = sales_analyst.average_items_per_merchant
    assert_equal 2.88, average
  end

  def test_average_average_price_per_merchant_sums_prices_across_all_merchants
    average_average = sales_analyst.average_average_price_per_merchant
    assert_equal BigDecimal.new("350.29"), average_average
    assert_instance_of BigDecimal, average_average
  end

  def test_average_invoice_per_merchant_returns_average_for_all_data
    average = sales_analyst.average_invoices_per_merchant
    assert_equal 10.49, average
  end

  def test_average_price_for_merchant_returns_average_price_for_the_item
    average = sales_analyst.average_item_price_for_merchant(12334112)
    assert_equal BigDecimal.new("15.00"), average
    assert_instance_of BigDecimal, average
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 3.26, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 3.29, sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count_returns_array
    assert_equal 12, sales_analyst.top_merchants_by_invoice_count.count
    assert_instance_of Merchant, sales_analyst.top_merchants_by_invoice_count.first
  end

  def test_bottom_merchants_by_invoice_count_returns_array
    assert_equal 4, sales_analyst.bottom_merchants_by_invoice_count.count
    assert_instance_of Merchant, sales_analyst.bottom_merchants_by_invoice_count.first
  end

  def test_invoices_by_day
    keys = ["Saturday", "Friday", "Wednesday", "Monday", "Sunday", "Tuesday", "Thursday"]
    assert_instance_of Hash, sales_analyst.invoices_by_day
    assert_equal keys, sales_analyst.invoices_by_day.keys
  end

  def test_top_days_by_invoice_count_returns_an_array_above_standard_deviation
    assert_equal ["Wednesday"], sales_analyst.top_days_by_invoice_count
  end

  def test_invoice_status_returns_percentage_based_on_status
    assert_equal 29.55, sales_analyst.invoice_status(:pending)
    assert_equal 56.95, sales_analyst.invoice_status(:shipped)
    assert_equal 13.5, sales_analyst.invoice_status(:returned)
  end

  def test_merchants_with_high_item_count_returns_merchants_one_std_from_avg
    high_count_merchants = sales_analyst.merchants_with_high_item_count
    assert_equal 52, high_count_merchants.count
  end

  def test_golden_items_returns_items_2_standard_deviations_from_average
    assert_equal 5, sales_analyst.golden_items.count
    assert_instance_of Item, sales_analyst.golden_items.first
  end

  def test_total_revenue_by_date_returns_total_for_that_day
    date = Time.parse("2009-02-07")
    assert_equal 21067.77, sales_analyst.total_revenue_by_date(date)
  end

  def test_paid_invoice_items_returns_Array_of_InvoiceItems
    invoice_items = sales_analyst.paid_invoice_items(12334123)
    assert_instance_of Array, invoice_items
    assert invoice_items.all? do |invoice_item|
      invoice_item.is_a? InvoiceItem
    end
  end

  def test_scores_by_item_id_totals_revenue_by_invoice_id
    revenue_by_invoice_item = sales_analyst.scores_by_item_id(12334123, &:total)
    assert_instance_of Hash, revenue_by_invoice_item
    assert revenue_by_invoice_item.all? do |item_id, total|
      item_id.is_a?(Integer) && total.is_a?(BigDecimal)
    end
  end

  def test_scores_by_item_id_can_total_quantity_by_id
    quantity_by_invoice_item = sales_analyst.scores_by_item_id(12334123, &:quantity)
    assert_instance_of Hash, quantity_by_invoice_item
    assert quantity_by_invoice_item.all? do |item_id, quantity|
      item_id.is_a?(Integer) && quantity.is_a?(Integer)
    end
  end

  def test_best_item_for_merchant_returns_item_with_most_generated_revenue
    best_item = sales_analyst.best_item_for_merchant(12337105)
    assert_instance_of Item, best_item
    assert_equal 263463003, best_item.id
  end

  def test_most_sold_item_sold_for_merchant_returns_item_with_highest_quantity
    most_sold_item = sales_analyst.most_sold_item_for_merchant(12337105)
    assert_instance_of Array, most_sold_item
    assert_equal 4, most_sold_item.length
  end

  def test_merchants_with_pending_invoices_returns_merchants_with_unsuccessful_transactions
    assert_instance_of Array, sales_analyst.merchants_with_pending_invoices
    assert_equal 467, sales_analyst.merchants_with_pending_invoices.count
  end

  def test_merchants_with_only_one_item_returns_an_array_with_merchant_selling_one_item
    assert_instance_of Array, sales_analyst.merchants_with_only_one_item
  end

  def test_merchants_with_only_one_item_registered_in_month_returns_an_array
    input = sales_analyst.merchants_with_only_one_item_registered_in_month("May")
    assert_instance_of Array, input
  end

  def test_average_price_returns_average_price
    average_price = sales_analyst.average_price
    expected = "0.251055106071689831748354059985e3"
    assert_equal BigDecimal.new(expected), average_price
    assert_instance_of BigDecimal, average_price
  end

  def test_revenue_by_merchant_returns_a_BigDecimal
    expected = BigDecimal.new('123696.45')
    actual = sales_analyst.revenue_by_merchant(12334141)
    assert_equal expected, actual
  end

  def test_top_revenues_by_earners_returns_array
    top_X = sales_analyst.top_revenue_earners(5)
    assert_equal 5, top_X.length
    assert_instance_of Array, top_X
    assert_instance_of Merchant, top_X.first
  end

  def test_top_revenues_by_earners_defaults_to_20
    top_20 = sales_analyst.top_revenue_earners
    assert_equal 20, top_20.length
    assert_instance_of Array, top_20
    assert_instance_of Merchant, top_20.first
  end

  def test_merchants_ranked_by_revenue_returns_an_array_of_all_merchants
    ranked = sales_analyst.merchants_ranked_by_revenue
    assert_instance_of Array, ranked
    assert_equal sales_engine.merchants.all.length, ranked.length
    assert ranked.all?{ |merchant| merchant.is_a? Merchant }
  end

  def test_rounded_rounds_value_two_decimal_points
    answer = 3.5556
    expected = 3.56
    assert_equal expected, sales_analyst.rounded(answer)
  end

  def test_rounded_rounds_value_takes_a_interger
    answer = 4
    expected = 4
    assert_equal expected, sales_analyst.rounded(answer)
  end

end
