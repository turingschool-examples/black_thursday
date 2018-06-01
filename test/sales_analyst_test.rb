require './test_helper'
require './lib/merchant'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/file_loader'
require './lib/sales_engine'
require './lib/invoice_repository'
require 'pry'

class SalesAnalystTest < MiniTest::Test
  include FileLoader
  def setup
    @sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })

    @sales_analyst = @sales_engine.analyst
  end

  def test_it_exists
    skip
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_can_get_average_items_per_merchant
    skip
    assert_equal 2.88, @sales_analyst.average_items_per_merchant
  end

  def test_it_can_get_average_items_per_merchant_standard_deviation
    skip
    assert_equal 3.26, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_can_get_single_merchants_total_items
    skip
    assert_equal 20, @sales_analyst.single_merchants_total_items(12334195)
  end

  def test_it_can_return_list_of_each_merchants_total_items
    skip
    assert_equal 475, @sales_analyst.each_merchants_total_items.length
  end

  def test_it_sums_numbers
    skip
    assert_equal 6, @sales_analyst.sum([1,2,3])
  end

  def test_can_find_merchants_with_high_item_count
    skip
    assert_equal 52, @sales_analyst.merchants_with_high_item_count.length
  end

  def test_can_find_average_item_price_for_merchant
    skip
    assert_equal 16.66, @sales_analyst.average_item_price_for_merchant(12334105)
    assert_instance_of BigDecimal, @sales_analyst.average_item_price_for_merchant(12334105)
  end

  def test_can_find_average_average_price_per_merchant
    skip
    assert_equal 350.29, @sales_analyst.average_average_price_per_merchant
    assert_instance_of BigDecimal, @sales_analyst.average_average_price_per_merchant
  end

  def test_can_find_golden_items
    skip
    assert_equal 5, @sales_analyst.golden_items.length
    assert_equal Item, @sales_analyst.golden_items.first.class
  end

  def test_can_find_average_invoices_per_merchant
    skip
    assert_equal 10.49, @sales_analyst.average_invoices_per_merchant
  end

  def test_can_find_average_invoices_per_merchant_standard_deviation
    skip
    assert_equal 3.29, @sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    assert_equal 12, @sales_analyst.top_merchants_by_invoice_count.length
  end
  # two standard deviations above the mean?

  def test_bottom_merchants_by_invoice_count
    assert_equal 4, @sales_analyst.bottom_merchants_by_invoice_count.length
  end
  # two standard deviations below the mean?

  def test_top_days_by_invoice_count
  end
  # # On which days are invoices created at more than one standard deviation above the mean?
  # def test_percentages_of_invoices
  # end
end
