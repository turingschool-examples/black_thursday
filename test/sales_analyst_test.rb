require_relative 'test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.new({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices  => "./fixtures/invoices_test.csv"
        })
    @sa = @se.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_returns_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
    assert_equal Float, @sa.average_items_per_merchant.class
  end

  def test_it_returns_the_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
    assert_equal Float, @sa.average_items_per_merchant_standard_deviation.class
  end

  def test_returns_merchants_more_than_one_standard_deviation_above_the_average_number_of_products_offered
     assert_equal 52, @sa.merchants_with_high_item_count.length
     assert_equal Merchant, @sa.merchants_with_high_item_count.first.class
  end

  def test_returns_the_average_item_price_for_the_given_merchant
      average_item_price = @sa.average_item_price_for_merchant(12334105)

      assert_equal 16.66, average_item_price
      assert_equal BigDecimal, average_item_price.class
  end

  def test_it_returns_the_average_price_for_all_merchants
     assert_equal 350.29, @sa.average_average_price_per_merchant

     assert_equal BigDecimal, @sa.average_average_price_per_merchant.class
  end

  def test_returns_items_that_are_two_standard_deviations_above_the_average_price
    assert_equal 5, @sa.golden_items.length
    assert_equal Item, @sa.golden_items.first.class
  end

  def test_it_returns_average_number_of_invoices_per_merchant
      assert_equal 7.08, @sa.average_invoices_per_merchant
      assert_equal Float, @sa.average_invoices_per_merchant.class
  end

  def test_it_returns_the_standard_deviation
    assert_equal 2.39, @sa.average_invoices_per_merchant_standard_deviation
    assert_equal Float, @sa.average_invoices_per_merchant_standard_deviation.class
  end

  def test_it_returns_top_merchants_by_invoice_count
    assert_equal 1 ,@sa.top_merchants_by_invoice_count.length
    assert_equal Merchant, @sa.top_merchants_by_invoice_count.first.class
  end

  def test_it_returns_bottom_merchants_by_invoice_count
    assert_equal 1 ,@sa.bottom_merchants_by_invoice_count.length
    assert_equal Merchant, @sa.bottom_merchants_by_invoice_count.first.class
  end

  def test_returns_days_with_an_invoice_count_more_than_one_standard_deviation_above_the_mean
    assert_equal 1, @sa.top_days_by_invoice_count.length
    assert_equal "Monday", @sa.top_days_by_invoice_count.first
    assert_equal String, @sa.top_days_by_invoice_count.first.class
  end

  def test_returns_the_percentage_of_invoices_with_given_status
    assert_equal 56.47, @sa.invoice_status(:pending)
    assert_equal 40.00, @sa.invoice_status(:shipped)
    assert_equal 3.53, @sa.invoice_status(:returned)
  end
end
