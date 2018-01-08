require_relative 'test_helper'
require_relative '../lib/sales_analyst'


class SalesAnalystTest < Minitest::Test

  attr_reader :sales_analyst

  def setup

    @se = SalesEngine.new({
      :items     => "./test/fixtures/items_sample.csv",
      :merchants => "./test/fixtures/merchants_sample.csv",
      :invoices => "./test/fixtures/invoices_sample.csv"
    })
    @sales_analyst = SalesAnalyst.new(@se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_it_returns_average
    assert_equal 3.57, sales_analyst.average_items_per_merchant
    refute_equal 0.43, sales_analyst.average_items_per_merchant
  end

  def test_it_returns_standard_deviation
    assert_equal 3.27, sales_analyst.average_items_per_merchant_standard_deviation
    refute_equal 3.20, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_returns_array_of_item_totals_for_merchants
    assert_equal 7, sales_analyst.number_of_items_per_merchant.count
    refute_equal 4, sales_analyst.number_of_items_per_merchant.count
  end

  def test_it_returns_merchants_with_highest_item_count
    assert_equal 1, sales_analyst.merchants_with_high_item_count.count
    refute_equal 10, sales_analyst.merchants_with_high_item_count.count
  end

  def test_it_returns_average_price_of_merchants_items
    assert_equal 0.2999e2, sales_analyst.average_item_price_for_merchant(12334105)
  end

  #Invoices BI Tests
  def test_it_returns_average_invoices_per_merchant
    assert_equal 1.71, sales_analyst.average_invoices_per_merchant
    refute_equal 2.00, sales_analyst.average_invoices_per_merchant
  end

  def test_it_returns_standard_deviation_for_invoices
    # skip
    assert_equal 0.84, sales_analyst.average_invoices_per_merchant_standard_deviation
    refute_equal 3.20, sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_it_returns_status_of_invoices_as_percentage
    assert_equal 
  end


end
