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
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    })

    @sales_analyst = @sales_engine.analyst
  end

  # def test_it_exists
  #   assert_instance_of SalesAnalyst, @sales_analyst
  # end
  #
  # def test_it_can_get_average_items_per_merchant
  #   assert_equal 2.88, @sales_analyst.average_items_per_merchant
  # end
  #
  # def test_it_can_get_average_items_per_merchant_standard_deviation
  #   assert_equal 3.26, @sales_analyst.average_items_per_merchant_standard_deviation
  # end
  #
  # def test_it_can_get_single_merchants_total_items
  #   assert_equal 20, @sales_analyst.single_merchants_total_items(12334195)
  # end
  #
  # def test_it_can_return_list_of_each_merchants_total_items
  #   assert_equal 475, @sales_analyst.each_merchants_total_items.length
  # end
  #
  # def test_it_sums_numbers
  #   assert_equal 6, @sales_analyst.sum([1,2,3])
  # end
  #
  # def test_can_find_merchants_with_high_item_count
  #   assert_equal 52, @sales_analyst.merchants_with_high_item_count.length
  # end
  #
  # def test_can_find_average_item_price_for_merchant
  #   assert_equal 16.66, @sales_analyst.average_item_price_for_merchant(12334105)
  #   assert_instance_of BigDecimal, @sales_analyst.average_item_price_for_merchant(12334105)
  # end
  #
  # def test_can_find_average_average_price_per_merchant
  #   assert_equal 350.29, @sales_analyst.average_average_price_per_merchant
  #   assert_instance_of BigDecimal, @sales_analyst.average_average_price_per_merchant
  # end
  #
  # def test_can_find_golden_items
  #   assert_equal 5, @sales_analyst.golden_items.length
  #   assert_equal Item, @sales_analyst.golden_items.first.class
  # end
  #
  # def test_can_find_average_invoices_per_merchant
  #   assert_equal 10.49, @sales_analyst.average_invoices_per_merchant
  # end
  #
  # def test_can_find_average_invoices_per_merchant_standard_deviation
  #   assert_equal 3.29, @sales_analyst.average_invoices_per_merchant_standard_deviation
  # end
  #
  # def test_top_merchants_by_invoice_count
  #   assert_equal 12, @sales_analyst.top_merchants_by_invoice_count.length
  # end
  # # two standard deviations above the mean?
  #
  # def test_bottom_merchants_by_invoice_count
  #   assert_equal 4, @sales_analyst.bottom_merchants_by_invoice_count.length
  # end
  # # two standard deviations below the mean?
  #
  # def test_top_days_by_invoice_count
  #   assert_equal 1, @sales_analyst.top_days_by_invoice_count.length
  #   assert_equal 'Wednesday', @sales_analyst.top_days_by_invoice_count.first
  # end
  # # # On which days are invoices created at more than one standard deviation above the mean?
  #
  # def test_percentages_of_invoices
  #   assert_equal 29.55, @sales_analyst.invoice_status(:pending)
  #   assert_equal 56.95, @sales_analyst.invoice_status(:shipped)
  #   assert_equal 13.5, @sales_analyst.invoice_status(:returned)
  # end
  #
  # def test_it_can_make_table_of_invoices_per_day
  #   assert_equal ({"Sunday"=>708, "Monday"=>696, "Tuesday"=>692, "Wednesday"=>741, "Thursday"=>718, "Friday"=>701, "Saturday"=>729}), @sales_analyst.invoice_per_day_table
  # end

  def test_it_can_check_if_an_invoice_is_paid_in_full
    assert @sales_analyst.invoice_paid_in_full?(1)
    assert @sales_analyst.invoice_paid_in_full?(200)
    refute @sales_analyst.invoice_paid_in_full?(203)
    refute @sales_analyst.invoice_paid_in_full?(204)
  end


end
