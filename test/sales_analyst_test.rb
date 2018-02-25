require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative 'test_helper'
require 'pry'

# test for sales analyst class
class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(items: './test/fixtures/items.csv',
                               merchants: './test/fixtures/merchants.csv',
                               invoices: './test/fixtures/invoices.csv',
                               invoice_items: './test/fixtures/invoice_items.csv',
                               transactions: './test/fixtures/transactions.csv',
                               customers: './test/fixtures/customers.csv')
    @sa = SalesAnalyst.new(@se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
    assert_equal @se, @sa.sales_engine
  end

  def test_average_items_per_merchant
    assert_equal 1.25, @sa.average_items_per_merchant
  end

  def test_standard_deviation
    assert_equal 1.5, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    high_count = @sa.merchants_with_high_item_count
    assert_instance_of Array, high_count
    assert_instance_of Merchant, high_count[0]
    assert_equal 2, high_count[0].id
  end

  def test_average_item_price_for_merchant
    assert_instance_of BigDecimal, @sa.average_item_price_for_merchant(2)
    assert_equal BigDecimal.new('16.66'), @sa.average_item_price_for_merchant(2)
  end

  def test_average_average_price_per_merchant
    assert_equal BigDecimal.new('7.35'), @sa.average_average_price_per_merchant
  end

  def test_all_item_prices
    assert_instance_of Array, @sa.all_item_prices
    assert_equal 5, @sa.all_item_prices.length
    assert_instance_of BigDecimal, @sa.all_item_prices[0]
  end

  def test_golden_items
    assert_instance_of Array, @sa.golden_items
    assert_equal 0, @sa.golden_items.length
  end

  def test_average_invoices_per_merchant
    assert_equal 2.25, @sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 1.26, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    assert_instance_of Array, @sa.top_merchants_by_invoice_count
    assert_equal 0, @sa.top_merchants_by_invoice_count.length
  end

  def test_bottom_merchants_by_invoice_count
    assert_instance_of Array, @sa.bottom_merchants_by_invoice_count
    assert_equal 0, @sa.bottom_merchants_by_invoice_count.length
  end

  def test_can_find_how_many_invoices_there_are_per_day
    assert_instance_of Hash, @sa.finding_number_of_invoices_per_day
  end

  def test_can_find_number_of_invoices_for_days_of_week
    assert_equal 9, @sa.invoice_dates.length
    assert_equal 2, @sa.finding_number_of_invoices_per_day["Saturday"]
  end

  def test_can_find_standard_deviation_for_invoices_on_days
    assert_equal 1.68, @sa.invoice_day_deviation
  end

  def test_can_find_top_days_by_invoice_count
    assert_equal ['Friday'], @sa.top_days_by_invoice_count
  end

  def test_can_find_percentage_of_certain_status
    assert_equal 55.56, @sa.invoice_status(:pending)
    assert_equal 44.44, @sa.invoice_status(:shipped)
  end

  def test_it_can_find_top_buyers
    assert_equal 0, @sa.top_buyers
  end

  def test_can_find_top_merchant_for_customer
    assert_instance_of Merchant, @sa.top_merchant_for_customer(1)
  end

  def test_one_time_buyers_top_items
    assert_equal 0, @sa.one_time_buyers_top_items
  end

  def test_it_can_find_total
    assert_equal 21067.77, @se.invoices.find_by_id(1).total
  end
end
