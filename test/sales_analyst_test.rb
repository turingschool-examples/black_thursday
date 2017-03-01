require './test/test_helper'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  include SalesEngineTestSetup


  def setup
    super
    @sa = SalesAnalyst.new(@se)
  end


  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_can_return_array_of_all_merchant_ids
    assert_equal 475, @sa.merchants.all.count
  end

  def test_average_items_per_merchant
    results = @sa.average_items_per_merchant
    assert_equal 2.88, results
  end

  def test_std_from_array
    assert_equal 3.90, @sa.std_dev_from_array([2,6,9.8])
    assert_equal 20.10, @sa.std_dev_from_array([11,4,0,0,0.45,13.5,56])
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal "Keckenbauer" , @sa.merchants_with_high_item_count.first.name
    assert_instance_of Array, @sa.merchants_with_high_item_count
  end

  def test_average_item_price_for_merchant
    assert_equal 0.315E2, @sa.average_item_price_for_merchant(12334159)
  end

  def test_average_average_price_per_merchant
    assert_equal 0.35029e3, @sa.average_average_price_per_merchant
  end

  def test_golden_items
    assert_equal 5, @sa.golden_items.count
    assert_equal "Test listing", @sa.golden_items.first.name
  end

  def test_average_invoices_per_merchant
    results = @sa.average_invoices_per_merchant
    assert_equal 10.49, results
  end

  def test_average_invoices_per_merchant_standard_deviation
    results = @sa.average_invoices_per_merchant_standard_deviation

    assert_equal 3.29, results
  end

  def test_top_merchants_by_invoice_count
    result = @sa.top_merchants_by_invoice_count

    assert_instance_of Array, result
    assert_equal "jejum", result.first.name
    assert_equal 12, result.count
  end

  def test_bottom_merchants_by_invoice_count
    result = @sa.bottom_merchants_by_invoice_count
    assert_instance_of Array, result
    assert_equal 4, result.count
    assert_equal "WellnessNeelsen", result.first.name
  end

  def test_top_days_by_invoice_count
    result = @sa.top_days_by_invoice_count
    assert_equal "Wednesday", result.first
    assert_instance_of Array, result
  end

  def test_percentage_merchants_by_status
    assert_equal 29.55, @sa.invoice_status(:pending)
    assert_equal 56.95, @sa.invoice_status(:shipped)
    assert_equal 13.5, @sa.invoice_status(:returned)
  end

end
