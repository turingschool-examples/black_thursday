require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'bigdecimal'

class SalesAnalystTest < Minitest::Test

  attr_reader :se,
              :sa

  def setup
    @se = SalesEngine.from_csv({
            :items => './test/fixtures/items_truncated_10.csv',
            :merchants => './test/fixtures/merchants_truncated_11.csv',
            :invoices => './test/fixtures/invoices_truncated_56.csv'})
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_average_items_per_merchant_returns_average
    assert_equal 0.91, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation_returns_standard_deviation
    assert_equal 1.58, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count_returns_merchants_array
    expected = [@se.merchants.find_by_id(12334123)]
    actual = sa.merchants_with_high_item_count

    assert_equal expected, actual
  end

  def test_average_item_price_for_merchant_returns_average_item_price_for_that_merchant
#TODO Ask why 5 is used vs a 4 in BigDecimal.new
    expected = BigDecimal.new((13000 + 40000 + 690 + 1490 + 14900)/100.0/5.0, 5)
    actual = sa.average_item_price_for_merchant(12334123)

    assert_equal expected, actual
  end

  def test_average_average_price_per_merchant_returns_average_item_price_across_all_merchants
    se = SalesEngine.from_csv({
            :items => './test/fixtures/items_truncated_10.csv',
            :merchants => './test/fixtures/merchants_truncated_4.csv',
            :invoices => './test/fixtures/invoices_truncated_56.csv'})
    sa = SalesAnalyst.new(se)

    merchant_1_avg = sa.average_item_price_for_merchant(12334105)
    merchant_2_avg = sa.average_item_price_for_merchant(12334112)
    merchant_3_avg = sa.average_item_price_for_merchant(12334115)
    merchant_4_avg = sa.average_item_price_for_merchant(12334123)

    expected = ((merchant_1_avg + merchant_2_avg + merchant_3_avg + merchant_4_avg)/4).truncate(2)
    actual = sa.average_average_price_per_merchant

    assert_equal expected, actual
  end

  def test_sa_can_find_average_item_price
    assert_equal 77.629, sa.average_item_price
  end

  def test_sa_can_find_standard_deviation_of_prices
    assert_equal 124.96739738827883, sa.item_price_standard_deviation
  end

  def test_sa_can_find_golden_items
    expected = [se.items.items[-2]]

    assert_equal expected, sa.golden_items
  end

  def test_sa_can_find_average_invoices_per_merchant
    assert_equal 5.090909090909091, sa.average_invoices_per_merchant
  end

  def test_sa_can_find_average_invoices_per_merchant_standard_deviation
    assert_equal 2.0225995873897267, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_sa_can_find_top_merchant_by_invoice_count
    assert_equal [@se.merchants.find_by_id(12334146)], sa.top_merchants_by_invoice_count
  end

  def test_sa_can_find_bottom_merchants_by_invoice_count
    assert_equal [@se.merchants.find_by_id(12334105)], sa.bottom_merchants_by_invoice_count
  end

  def test_sa_can_find_average_invoices_created_per_day
    assert_equal 8, sa.average_invoices_created_per_day
  end

  def test_sa_can_find_number_of_invoices_created_per_day
    assert_equal [6, 7, 10, 2, 8, 14, 9], sa.number_of_invoices_created_per_day
  end

  def test_sa_can_find_average_number_of_invoices_created_per_day_standard_deviation
    assert_equal 3.696845502136472, sa.number_of_invoices_created_per_day_standard_deviation
  end

  def test_sa_can_find_top_days_by_invoice_count
    assert_equal ["Friday"], sa.top_days_by_invoice_count
  end

  def test_sa_can_find_total_amount_of_invoices
    assert_equal 56, sa.total_invoices_count
  end

  def test_sa_can_calculate_invoice_status_percentage
    assert_equal 0.875, sa.invoice_status(:pending)
    assert_equal 0.07142857142857142, sa.invoice_status(:shipped)
    assert_equal 0.05357142857142857, sa.invoice_status(:returned)
  end




end
