require_relative 'test_helper'

require './lib/sales_engine'
require './test/test_data'

class SalesAnalystTest < Minitest::Test
  include TestData
  def setup
    make_some_test_data
    se = SalesEngine.new(@itemr,@mr,@ir,@iir,@cr,@tr)
    @sa = se.analyst
  end

  # def test_average_items_per_merchant
  #   skip
  #   assert_equal 4.86, @sa.average_items_per_merchant
  # end
  #
  # def test_average_items_per_merchant_standard_deviation
  #   skip
  #   assert_equal 6.91, @sa.average_items_per_merchant_standard_deviation
  # end
  #
  # def test_merchants_with_high_item_count
  #   skip
  #   assert_equal 1, @sa.merchants_with_high_item_count.size
  # end
  #
  # def test_average_item_price_for_merchant
  #   skip
  #   assert_equal 0.8, @sa.average_item_price_for_merchant(12334235)
  # end
  #
  # def test_average_average_price_per_merchant
  #   skip
  #   assert_equal 0.88, @sa.average_average_price_per_merchant
  # end
  #
  # def test_golden_items
  #   skip
  #   assert_equal 0, @sa.golden_items.length
  # end
  #
  # def test_it_finds_percentage_of_invoices_status_returned
  #   skip
  #   assert_equal 19.18, @sa.invoice_status(:returned)
  # end
  #
  # def test_it_finds_percentage_of_invoices_status_pending
  #   skip
  #   assert_equal 39.73, @sa.invoice_status(:pending)
  # end
  #
  # def test_it_finds_percentage_of_invoices_status_shipped
  #   skip
  #   assert_equal 41.1, @sa.invoice_status(:shipped)
  # end
  #
  # def test_average_invoices_per_merchant
  #   skip
  #   assert_equal 10.43, @sa.average_invoices_per_merchant
  # end
  #
  # def test_average_invoices_per_merchant_standard_deviation
  #   skip
  #   assert_equal 4.79, @sa.average_invoices_per_merchant_standard_deviation
  # end
  #
  # def test_top_merchants_by_invoice_count
  #   skip
  #   assert_equal 0, @sa.top_merchants_by_invoice_count.size
  # end
  #
  # def test_bottom_merchants_by_invoice_count
  #   skip
  #   assert_equal 0, @sa.bottom_merchants_by_invoice_count.size
  # end
  #
  # def test_top_days_by_invoice_count
  #   skip
  #   assert_equal [], @sa.top_days_by_invoice_count
  # end

  def test_top_buyers_passing_number
    @sa.top_buyers
  end

  # def test_it_finds_top_merchants_for_a_customer
  #   skip
  #   id = @sa.customers.all[10].id
  #
  #   @sa.top_merchant_for_customer(id)
  # end
end
