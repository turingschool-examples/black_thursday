require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa, :sasd

  def setup
    se_hash = {:items => './data/test_items.csv',
            :merchants => './data/test_merchant.csv',
             :invoices => './data/test_invoices.csv'}
    se = SalesEngine.new(se_hash)
    @sa = SalesAnalyst.new(se)

    sesd_hash = { :items => './data/test_items_sd.csv',
                :merchants => './data/test_merchant_sd.csv',
                :invoices => './data/test_invoices.csv'}
    sesd = SalesEngine.new(sesd_hash)
    @sasd = SalesAnalyst.new(sesd)
  end

  def test_for_instance_of_sales_analyst
    assert sa.instance_of?(SalesAnalyst)
  end

  def test_total_merchants_returns_count_of_all_merchants
    assert_equal 5, sa.total_merchants
  end

  def test_total_items_returns_count_of_all_items
    assert_equal 5, sa.total_items
  end

  def test_average_items_per_merchant
    assert_equal 1, sa.average_items_per_merchant
  end

  def test_variance_of_average_and_times
    assert_equal 4.0, sa.variance_of_average_and_items
  end

  def test_variance_divided_by_merchants
    assert_equal 1.0, sa.variance_of_average_and_items_divided_merchants
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 1.0, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_low_item_count_returns_instance_of_merchants
    low_item = sasd.merchants_with_low_item_count
    assert low_item.first.instance_of?(Merchant)
  end

  def test_merchants_with_low_item_count
    assert_equal 1, sasd.merchants_with_low_item_count.count
  end

  def test_average_price_for_merchant
    assert_equal 705.24, sasd.average_item_price_for_merchant(1)
  end

  def test_average_price_per_merchant
    assert_equal 439.20, sasd.average_price_per_merchant
    assert_equal BigDecimal, sasd.average_price_per_merchant.class
  end

  def test_average_price_of_all_items
    assert_equal 533.31, sasd.average_price_of_all_items
  end

  def test_variance_of_all_item_prices_from_mean
    assert_equal 4326479.81, sasd.variance_of_all_item_prices_from_mean
  end

  def test_items_variance_divide_total_items
    assert_equal 77258.57, sasd.variance_divide_total_items
  end

  def test_items_standard_deviation_returns_sd_in_big_d
    assert_equal 277.95, sasd.items_standard_deviation
  end

  def test_golden_items_returns_item_object_instance
    assert sasd.golden_items[0].instance_of?(Item)
  end

  def test_golden_items_returns_items_two_sd_above_avg
    assert_equal 1, sasd.golden_items.count
  end

  def test_average_invoices_per_merchant
    assert_equal 12.2, sa.average_invoices_per_merchant
  end

  def test_total_invoices_returned
    assert_equal 36, sa.total_invoices_with_common_status(:shipped)
  end

  def test_invoice_status_returns_percentage_of_invoices_with_shipped_status
    assert_equal 59.0, sa.invoice_status(:shipped)
  end

  def test_invoice_status_returns_percentage_of_invoices_with_pending_status
    assert_equal 34.4, sa.invoice_status(:pending)
  end

  def test_invoice_status_returns_percentage_of_invoices_with_returned_status
    assert_equal 6.6, sa.invoice_status(:returned)
  end

  def test_invoice_status_returns_zero_of_invoices_with_other_status
    assert_equal 0.0, sa.invoice_status(:other)
  end

  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 4.97, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    assert_equal [], sa.top_merchants_by_invoice_count
  end

  def test_bottom_merchants_by_invoice_count
    assert_equal [], sa.bottom_merchants_by_invoice_count
  end

  def test_top_days_by_invoice_count

  end

end
