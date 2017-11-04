require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'pry'

class SalesAnalystTest < Minitest::Test

  def setup
    sales_engine = SalesEngine.from_csv({:items => './test/fixtures/items_fixture.csv',
                                        :merchants => './test/fixtures/merchants.csv',
                                        :invoices => './test/fixtures/invoices.csv',
                                        :invoice_items => './test/fixtures/invoice_items.csv'})
    @sales_analyst = SalesAnalyst.new(sales_engine)
  end

  def test_that_we_find_average_items_per_merchant
    assert_equal 2.0, @sales_analyst.average_items_per_merchant
  end

  def test_it_can_find_standard_deviation
    assert_equal 0.87, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_can_find_merchants_with_high_item_count
    merchant_1 = @sales_analyst.sales_engine.merchants.merchants[0]
    assert_equal [merchant_1], @sales_analyst.merchants_with_high_item_count
  end

  def test_it_can_determine_average_price_for_merchant_with_id
    assert_equal 48.33, @sales_analyst.average_item_price_for_merchant(12334112)
  end

  def test_it_can_determine_average_price_per_merchant
    assert_equal 233.66, @sales_analyst.average_average_price_per_merchant
  end

  def test_it_can_find_golden_items
    item_1 = @sales_analyst.sales_engine.items.all[8]
    assert_equal [item_1], @sales_analyst.golden_items
  end

  def test_it_can_find_average_invoices_per_merchant
    assert_equal 3.8, @sales_analyst.average_invoices_per_merchant
  end

  def test_it_can_find_average_items_per_merchant_standard_deviation
    assert_equal 1.79, @sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_it_can_find_top_merchants_by_invoice_count
    merchant_1 = @sales_analyst.sales_engine.merchants.merchants[0]
    assert_equal [merchant_1], @sales_analyst.top_merchants_by_invoice_count
  end

  def test_it_can_find_bottom_merchants_by_invoice_count
    merchant_1 = @sales_analyst.sales_engine.merchants.merchants[4]
    assert_equal [merchant_1], @sales_analyst.bottom_merchants_by_invoice_count
  end

  def test_it_detects_which_day_of_the_week_has_most_sales
    assert_equal ["Friday", "Saturday"], @sales_analyst.top_days_by_invoice_count
  end

  def test_percentage_of_instances_of_statuses
    assert_equal 47.37, @sales_analyst.invoice_status(:pending)
    assert_equal 47.37, @sales_analyst.invoice_status(:shipped)
    assert_equal 5.26, @sales_analyst.invoice_status(:returned)
  end


end
