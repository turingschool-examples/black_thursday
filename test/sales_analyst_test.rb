require 'bigdecimal'

require './test/test_helper'
require './lib/sales_analyst'


class SalesAnalystTest < Minitest::Test

  attr_reader :sales_analyst
  def setup
    @sales_analyst = SalesAnalyst.new(Fixture.sales_engine)
  end

  def test_an_instance_exists_and_takes_sales_engine
    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_average_items_per_merchant_returns_float
    average = sales_analyst.average_items_per_merchant
    assert_equal 0.67, average
  end

  def test_standard_deviation_returns_std
    assert_equal 0.82, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count_returns_merchants_one_std_from_avg

    high_count_merchants = sales_analyst.merchants_with_high_item_count
    assert_equal ["merchant 1", "merchant 2",  "merchant 3"], high_count_merchants
  end

  def test_average_price_for_merchant_returns_average_price_for_the_item
    average = sales_analyst.average_item_price_for_merchant(2)
    assert_equal BigDecimal.new("2.5"), average
    assert_instance_of BigDecimal, average
  end

  def test_average_average_price_per_merchant_sums_prices_across_all_merchants
    average_average = sales_analyst.average_average_price_per_merchant
    assert_equal BigDecimal.new("1.5"), average_average
    assert_instance_of BigDecimal, average_average
  end

  def test_golden_items_returns_items_2_standard_deviations_from_average

    assert_equal 1, sales_analyst.golden_items.count
    assert_equal "Cherry", sales_analyst.golden_items.first.name
  end

  def test_average_invoice_per_merchant_returns_average_for_all_data
    average = sales_analyst.average_invoice_per_merchan
    assert_equal 10.49, average
  end

  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 3.29, sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count_returns_array
    assert_equal 3, sales_analyst.top_merchants_by_invoice_count.count
    assert_equal "Candisart", sales_analyst.top_merchants_by_invoice_count.name
  end

  def test_bottom_merchants_by_invoice_count_returns_array
    assert_equal 1, sales_analyst.bottom_merchants_by_invoice_count.count
    assert_equal "NA", sales_analyst.bottom_merchants_by_invoice_count.name
  end

  def test_top_days_by_invoice_count_returns_an_array_above_standard_deviation
    assert_equal ["sunday", "monday"], sales_analyst.top_days_by_invoice_count
  end

  def test_invoice_status_returns_percentage_based_on_status
    assert_equal 29.55, sales_analyst.invoice_status(:pending)
    assert_equal 56.95, sales_analyst.invoice_status(:shipped)
    assert_equal 13.5, sales_analyst.invoice_status(:returned)
  end



end
