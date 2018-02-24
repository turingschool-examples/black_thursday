# frozen_string_literal: true

require_relative 'test_helper.rb'
require_relative '../lib/sales_analyst.rb'
require_relative '../lib/sales_engine.rb'
require 'bigdecimal'

require_relative './master_hash.rb'


class SalesAnalystTest < Minitest::Test
  def setup
    test_engine = TestEngine.new.god_hash
    @sales_engine = SalesEngine.new(test_engine)
    @sales_analyst = SalesAnalyst.new(@sales_engine)
  end

  def test_analyst_initializes
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_item_collect_helper_method_works
    result = @sales_analyst.item_collector

    assert_instance_of Array, result
    assert_instance_of Item, result[0]
  end

  def test_can_return_average_items_per_merchant
    result = @sales_analyst.average_items_per_merchant

    assert_equal 0.56, result
  end

  def test_standard_deviation_method_is_accurate
    data_set = [3,4,5]
    result = @sales_analyst.standard_deviation(4, data_set)

    assert_equal 1.0, result
  end

  def test_mean_method_is_accurate
    data_set = [3,4,5]
    result = @sales_analyst.find_mean(data_set)

    assert_equal 4, result
  end

  def test_can_return_standard_deviation_items_per_merchant
    skip
    result = @sales_analyst.average_items_per_merchant_standard_deviation

    assert_equal 0.57, result
  end

  def test_can_find_merchants_with_high_item_count
    result = @sales_analyst.merchants_with_high_item_count

    assert_instance_of Array, result
    # fixture data too small for high item count
    assert_nil result[0]
  end

  def test_can_find_average_item_price_of_merchant
    result = @sales_analyst.average_item_price_for_merchant(12_334_105)

    assert_instance_of BigDecimal, result
    assert_equal 0.2999e2, result
  end

  def test_can_find_average_of_average_merchant_item_price
    skip
    result = @sales_analyst.average_average_price_per_merchant
    #some merchants don't have items in fixture data, hence div by 0 error

    assert_equal 41.99, result.round(2)
    assert_instance_of Float, result
  end

  def test_can_find_golden_items
    skip
    result = @sales_analyst.golden_items

    assert_instance_of Array, result
    #fixture data too small for golden item
    assert_nil result[0]
  end

  def test_merchant_collector_helper_method_works
    result = @sales_analyst.merchant_collector

    assert_instance_of Array, result
    assert_instance_of Merchant, result[0]
  end

  def test_gets_standard_deviation_of_all_item_prices_helper_method
    result = @sales_analyst.price_standard_deviation

    assert_instance_of BigDecimal, result
    assert_equal BigDecimal.new(8.72, 3), result
  end

  def test_find_average_invoices_per_merchant
    skip
    result = @sales_analyst.average_invoices_per_merchant

    assert_equal 1.56, result
  end

  def test_can_return_standard_deviation_invoices_per_merchant
    skip
    result = @sales_analyst.average_invoices_per_merchant_standard_deviation

    assert_equal 1.65, result
  end

  def test_can_find_top_merchants_by_invoice_count
    result = @sales_analyst.top_merchants_by_invoice_count

    assert_instance_of Array, result
    # fixture data too small to have above average merchants
    assert_nil result[0]
  end

  def test_can_find_bottom_merchants_by_invoice_count
    result = @sales_analyst.bottom_merchants_by_invoice_count

    assert_instance_of Array, result
    # fixture data too small to have below average merchants
    assert_nil result[0]
  end

  def test_can_find_top_days_by_invoice_count
    result = @sales_analyst.top_days_by_invoice_count

    assert_equal ["Friday"], result
  end

  def test_can_return_invoice_statuses_as_percent_share
    skip
    pending_result = @sales_analyst.invoice_status(:pending)
    shipped_result = @sales_analyst.invoice_status(:shipped)
    returned_result = @sales_analyst.invoice_status(:returned)

    assert_equal 57.14, pending_result
    assert_equal 42.86, shipped_result
    assert_equal 0.0, returned_result
  end
end
