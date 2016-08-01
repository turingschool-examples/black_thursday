require './test/test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa

  def setup
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices  => "./test/fixtures/invoices_fixture.csv",
      :invoice_items => "./test/fixtures/invoice_items_fixture.csv"
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_has_sales_engine
    assert_instance_of SalesEngine, sa.engine
  end

  def test_method_average_items_per_merchant_returns_float
    mock_se = Minitest::Mock.new
    sa = SalesAnalyst.new(mock_se)
    mock_se.expect(:items_per_merchant,[3,4,5], [])
    assert_equal 4.0, sa.average_items_per_merchant
    mock_se.expect(:items_per_merchant,[22,40,12,19,30], [])
    assert_equal 24.6, sa.average_items_per_merchant
  end

  def test_method_average_items_per_merchant_standard_deviation_returns_float
    mock_se = Minitest::Mock.new
    sa = SalesAnalyst.new(mock_se)
    mock_se.expect(:items_per_merchant,[3,4,5], [])
    assert_equal 1.0, sa.average_items_per_merchant_standard_deviation
    mock_se.expect(:items_per_merchant,[22,40,12,19,30], [])
    assert_equal 10.76, sa.average_items_per_merchant_standard_deviation
  end

  def test_method_merchants_with_high_item_count_returns_array_of_merchants
    assert_instance_of Array, sa.merchants_with_high_item_count
    assert_instance_of Merchant, sa.merchants_with_high_item_count[0]
  end

  def test_method_average_average_price_per_merchant_returns_big_decimal
    assert_instance_of BigDecimal, sa.average_average_price_per_merchant
  end

  def test_method_golden_items_returns_array_of_items
    assert_instance_of Array, sa.golden_items
    assert_instance_of Item, sa.golden_items[0]
  end

  def test_method_average_invoices_per_merchant_returns_float
    assert_instance_of Float, sa.average_invoices_per_merchant
  end

  def test_method_average_invoices_per_merchant_standard_deviation_returns_float
    assert_instance_of Float, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_method_top_merchants_by_invoice_count_returns_array_of_merchants
    assert_instance_of Array, sa.top_merchants_by_invoice_count
  end

  def test_method_bottom_merchants_by_invoice_count_returns_array_of_merchants
    assert_instance_of Array, sa.bottom_merchants_by_invoice_count
  end

  def test_method_top_days_by_invoice_count_returns_array
    mock_se = Minitest::Mock.new
    sa = SalesAnalyst.new(mock_se)
    mock_se.expect(:total_invoices_by_weekday,{"Saturday"=>729,
                                               "Friday"=>701,
                                               "Wednesday"=>741,
                                               "Monday"=>696,
                                               "Sunday"=>708,
                                               "Tuesday"=>692,
                                               "Thursday"=>718}, [])
    assert_equal ["Wednesday"], sa.top_days_by_invoice_count
  end

  def test_method_invoice_status_sum_for_all_three_is_100_percent
    sum = sa.invoice_status(:pending) +
          sa.invoice_status(:shipped) +
          sa.invoice_status(:returned)
    assert_equal 100.0, sum
  end
end
