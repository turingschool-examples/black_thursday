require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'

class TestSalesAnalyst < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      items:      "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:   "./data/invoices.csv"
      })
    @sales_analyst = SalesAnalyst.new(@sales_engine)
  end
  #
  # def test_it_exists
  #   assert_instance_of SalesAnalyst, @sales_analyst
  # end
  #
  # def test_it_finds_average_items_per_merchant
  #   skip
  #   assert_equal 2.88, @sales_analyst.average_items_per_merchant
  #   assert_instance_of Float, @sales_analyst.average_items_per_merchant
  # end
  #
  # def test_it_item_count_of_all_merchants
  #   assert_equal 475, @sales_analyst.all_merchant_item_count.length
  # end
  #
  # def test_it_can_find_standard_deviation
  #   skip
  #   merchant_items = @sales_analyst.all_merchant_item_count.values
  #   assert_equal 3.26, @sales_analyst.average_items_per_merchant_standard_deviation
  #   assert_instance_of Float, @sales_analyst.average_items_per_merchant_standard_deviation
  # end
  #
  # def test_it_can_find_high_merchant_items
  #   assert_equal 52, @sales_analyst.merchants_with_high_item_count.length
  #   assert_equal Merchant, @sales_analyst.merchants_with_high_item_count.first.class
  # end
  #
  # def test_it_can_find_average_item_price_for_merchant
  #   merchant_id = 12334105
  #   assert_equal 16.66, @sales_analyst.average_item_price_for_merchant(merchant_id)
  #   assert_equal BigDecimal, @sales_analyst.average_item_price_for_merchant(merchant_id).class
  # end
  #
  # def test_it_can_find_average_average_item_price_for_merchant
  #   assert_equal 350.29, @sales_analyst.average_average_price_per_merchant
  #   assert_equal BigDecimal, @sales_analyst.average_average_price_per_merchant.class
  # end
  #
  # def test_it_can_find_average_invoices_per_merchant
  #   assert_equal 10.49, @sales_analyst.average_invoices_per_merchant
  #   assert_equal Float, @sales_analyst.average_invoices_per_merchant.class
  # end
  # #
  # def test_invoice_standard_dev_helper_methods
  #   assert_equal 3.29, @sales_analyst.average_invoices_per_merchant_standard_deviation
  # end

  def test_top_merchants_by_invoice_count
    assert_equal 12, @sales_analyst.top_merchants_by_invoice_count.length
    assert_equal Merchant, @sales_analyst.top_merchants_by_invoice_count.first.class
  end
end
