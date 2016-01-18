require_relative './../lib/sales_analyst'
require_relative './spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'
require          'mocha/mini_test'


class SalesAnalystTest < Minitest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
              :items     => "./data/sample/items_sample.csv",
              :merchants => "./data/sample/merchants_sample.csv",
              :invoices  => "./data/sample/invoice_sample.csv"
                              })
  end

  def test_that_class_exist
    assert SalesAnalyst
  end

  def test_that_average_items_per_merchant_method_exist
      assert SalesAnalyst.method_defined? :average_items_per_merchant
  end

  def test_that_average_items_per_merchant_standard_deviation_method_exist
      assert SalesAnalyst.method_defined? :average_items_per_merchant_standard_deviation
  end

  def test_that_merchants_with_low_item_count_method_exist
      assert SalesAnalyst.method_defined? :merchants_with_high_item_count
  end

  def test_that_average_item_price_for_merchant_method_exist
      assert SalesAnalyst.method_defined? :average_item_price_for_merchant
  end

  def test_that_golden_items_method_exist
      assert SalesAnalyst.method_defined? :golden_items
  end

  def test_that_items_are_attached_to_merchant
    merchant = se.merchants.find_by_id(22)


    assert_equal [2222, 3333, 4444], merchant.items.map(&:id)
  end

  def test_that_merchant_are_attached_to_merchant
    item = se.items.find_by_id("1111")

    assert_equal "Store One", item.merchant.name
  end

  def test_that_average_items_per_merchant_works
    sa = SalesAnalyst.new(se)

    assert_equal 1.5, sa.average_items_per_merchant
  end

  def test_that_the_standard_deviation_is_calculated
    sa = SalesAnalyst.new(se)

    assert_equal 1.05, sa.average_items_per_merchant_standard_deviation
  end

  def test_which_merchants_sell_the_most_items
    sa = SalesAnalyst.new(se)

    assert_equal 1, sa.merchants_with_high_item_count.length
  end

  def test_average_item_price_for_merchant
    sa = SalesAnalyst.new(se)
    average = sa.average_item_price_for_merchant(22)

    assert_equal 2.33, average.to_f
  end


  def test_average_average_price_per_merchant
    sa = SalesAnalyst.new(se)
    average = sa.average_average_price_per_merchant

    assert_equal 52.98, average.to_f
  end

  def test_golden_items
    sa = SalesAnalyst.new(se)

    assert_equal 1, sa.golden_items.count
  end

  def test_average_invoices_per_merchant
    sa = SalesAnalyst.new(se)

    assert_equal 1.67, sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    sa = SalesAnalyst.new(se)

    assert_equal 1.21, sa.average_invoices_per_merchant_standard_deviation
  end
# meta run: true
  def test_top_merchants_by_invoice_count
    skip
    sa = SalesAnalyst.new(se)
    sa.stubs(:two_standard_dev_above_mean_invoices).returns(2.5)

    assert_equal 1, sa.top_merchants_by_invoice_count.count
  end

  def test_bottom_merchants_by_invoice_count
    skip
    sa = SalesAnalyst.new(se)
    sa.stubs(:two_standard_dev_below_mean_invoices).returns(1.5)

    assert_equal 4, sa.bottom_merchants_by_invoice_count.count
  end

  def test_top_days_by_invoice_count
    sa = SalesAnalyst.new(se)
#need to use stubs on this test
    assert_equal [:Friday], sa.top_days_by_invoice_count
  end

  def test_percentage_of_invoices_pending
    sa = SalesAnalyst.new(se)

    assert_equal 60.0, sa.invoice_status(:pending)
  end

  def test_percentage_of_invoices_shipped
    sa = SalesAnalyst.new(se)

    assert_equal 40.0, sa.invoice_status(:shipped)
  end

  def test_percentage_of_invoices_shipped_vs_pending_vs_returned
    sa = SalesAnalyst.new(se)
    pending = sa.invoice_status(:pending)
    shipped = sa.invoice_status(:shipped)
    returned = sa.invoice_status(:returned)

    assert_equal 100.0, pending + shipped + returned
  end

  def test_print_percentage_of_invoice_percentages
    sa = SalesAnalyst.new(se)
    pending = sa.invoice_status(:pending)
    shipped = sa.invoice_status(:shipped)
    returned = sa.invoice_status(:returned)

    printed = "Percentage of invoices shipped: 40.0% vs.
    pending 60.0% vs. returned 0.0%"

    assert_equal printed, sa.percentage_of_invoices_shipped_vs_pending_vs_returned
  end

end
