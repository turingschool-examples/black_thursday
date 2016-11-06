require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  attr_reader :sales_analyst, :sales_analyst2
  def setup
    @sales_engine = SalesEngine.from_csv({
      :items     => "./data/test_items.csv",
      :merchants => "./data/test_merchants.csv",
      :invoices  => "./data/test_invoices.csv"
    })
    @sales_engine_mock = Minitest::Mock.new
    @sales_analyst     = SalesAnalyst.new(@sales_engine)
    @sales_analyst2    = SalesAnalyst.new(@sales_engine_mock)
  end

  def test_it_exists
    assert sales_analyst
  end

  def test_it_takes_sales_engine_instance_as_argument
    assert SalesAnalyst.new(@sales_engine_mock)
  end

  def test_items_calls_sales_engine
    sales_analyst2.sales_engine.expect(:all_items, nil, [])
    sales_analyst2.items
    sales_analyst2.sales_engine.verify
  end

  def test_merchants_calls_sales_engine
    sales_analyst2.sales_engine.expect(:all_merchants, nil, [])
    sales_analyst2.merchants
    sales_analyst2.sales_engine.verify
  end

  def test_invoices_calls_sales_engine
    sales_analyst2.sales_engine.expect(:all_invoices, nil, [])
    sales_analyst2.invoices
    sales_analyst2.sales_engine.verify
  end

  def test_average_items_per_merchant_returns_a_float
    assert Float, sales_analyst.average_items_per_merchant.class
    assert_equal 0.76, sales_analyst.average_items_per_merchant
  end

  def test_it_calls_sales_engine_object
    assert SalesEngine, sales_analyst.sales_engine.class
  end

  def test_avg_items_per_merch_std_dev_returns_std_dev
    assert_equal 2.02, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_average_item_price_per_merchant_returns_a_Big_Decimal
    assert BigDecimal, sales_analyst.average_item_price_for_merchant(12334185).class
  end

  def test_it_calculates_the_average_item_price_per_merchant
    expected = 11.17
    result = sales_analyst.average_item_price_for_merchant(12334185)
    assert_equal expected, result.to_f
  end

  def test_it_finds_merchants_with_items_greater_than_one_std_dev
    high_rollers = sales_analyst.merchants_with_high_item_count
    assert high_rollers.all?{|merchant| merchant.class == Merchant}
    assert high_rollers.all?{|merchant| merchant.items.count > 2.92}
    assert_equal 10, high_rollers.count
  end

  def test_average_average_price_per_merchant_returns_a_Big_Decimal
    assert BigDecimal, sales_analyst.average_average_price_per_merchant
  end

  def test_it_finds_the_average_of_average_price_per_merchant
    assert_equal 814.8, sales_analyst.average_average_price_per_merchant
  end

  def test_golden_items_returns_items_with_price_greater_than_2_std_devs_above_avg_price
    gold_items = sales_analyst.golden_items
    assert gold_items.all?{|item| item.unit_price > 18221.5}
    assert gold_items.all?{|item| item.class == Item}
    assert_equal 1, gold_items.count
  end

  def test_average_invoices_per_merchant_returns_a_float_average
    assert_equal Float, sales_analyst.average_invoices_per_merchant.class
    assert_equal  0.11, sales_analyst.average_invoices_per_merchant
  end
  
  def test_invoices_per_merchant_standard_deviation
    assert_equal Float, sales_analyst.average_invoices_per_merchant_standard_deviation.class
    assert_equal 0.32, sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count_returns_array_of_top_merchants
    assert_equal Array, sales_analyst.top_merchants_by_invoice_count.class
  end
  
  def test_bottom_merchants_by_invoice_count_returns_array_of_bottom_merchants
    assert_equal Array, sales_analyst.bottom_merchants_by_invoice_count.class
  end

  def test_invoice_days_returns_array_of_day_numbers
    assert_equal Array, sales_analyst.invoice_days.class
    assert_equal sales_analyst.invoices.count, sales_analyst.invoice_days.count
  end

  def test_invoice_days_returns_day_name
    assert sales_analyst.invoice_days.all?{|day| day.include?("day")}
  end

  def test_average_invoices_per_day
    assert_equal 10.57, sales_analyst.average_invoices_per_day
  end

  def test_average_invoices_per_day_std_dev
    assert_equal 3.1, sales_analyst.average_invoices_per_day_standard_deviation
  end

  def test_top_days_by_invoice_count_returns_top_day_or_days
    assert_equal ["Friday"], sales_analyst.top_days_by_invoice_count
  end
  
  def test_invoice_status_returns_a_float
    status = :pending
    assert_equal Float, sales_analyst.invoice_status(status).class
  end

  def test_invoice_status_returns_the_percentage_of_the_status
    status = :pending
    assert_equal 28.38, sales_analyst.invoice_status(status)
  end

  def test_total_revenue_by_date_returns_total_rev_by_date
    date = Time.parse("2012-02-26")
    assert_equal 0, sales_analyst.total_revenue_by_date(date)
  end

  def test_top_revenue_earners
    assert_equal Merchant, sales_analyst.top_revenue_earners(5)[2].class
  end

  def test_merchants_ranked_by_revenue
    assert_equal Merchant, sales_analyst.merchants_ranked_by_revenue[2].class
  end

  def test_merchants_with_pending_invoices
    assert_equal Merchant, sales_analyst.merchants_with_pending_invoices
  end

end
