require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def test_sales_analyst_class_exists
    se = SalesEngine.from_csv(file_path)
    assert_instance_of SalesAnalyst, SalesAnalyst.new(se)
  end

  def test_sales_analyst_knows_average_items_per_merchant
    se = SalesEngine.from_csv(file_path)
    assert_equal 2.88, SalesAnalyst.new(se).average_items_per_merchant
  end

  def test_sales_analyst_can_calculate_average_items_per_merchant_with_standard_deviation
    se = SalesEngine.from_csv(file_path)
    assert_equal 3.26, SalesAnalyst.new(se).average_items_per_merchant_standard_deviation
  end

  def test_sales_analyst_can_find_merchants_that_exceed_one_standard_deviation
    se = SalesEngine.from_csv(file_path)
    assert_equal 52, SalesAnalyst.new(se).merchants_with_high_item_count.count
  end

  def test_sales_analyst_can_find_average_item_price_for_merchant_by_id
    se = SalesEngine.from_csv(file_path)
    assert_equal 33.5, SalesAnalyst.new(se).average_item_price_for_merchant(12334871)
    assert_equal 813.33, SalesAnalyst.new(se).average_item_price_for_merchant(12334371).round(2)
  end

  def test_sales_analyst_can_find_the_average_average_price_per_merchant
    se = SalesEngine.from_csv(file_path)
    assert_equal 350.29, SalesAnalyst.new(se).average_average_price_per_merchant
  end

  def test_sales_analyst_can_find_the_golden_items
    se = SalesEngine.from_csv(file_path)
    assert_equal 5, SalesAnalyst.new(se).golden_items.count
  end

  def test_sales_analyst_can_find_the_average_of_invoices_per_merchant
    se = SalesEngine.from_csv(file_path)
    assert_equal 10.49, SalesAnalyst.new(se).average_invoices_per_merchant
  end

  def test_sales_analyst_can_calculate_average_invoices_per_merchant_with_standard_deviation
    se = SalesEngine.from_csv(file_path)
    assert_equal 3.29, SalesAnalyst.new(se).average_invoices_per_merchant_standard_deviation
  end

  def test_sales_analyst_can_calculate_top_merchants_by_invoice_count
    se = SalesEngine.from_csv(file_path)
    assert_equal 12, SalesAnalyst.new(se).top_merchants_by_invoice_count.count
  end

  def test_sales_analyst_can_calculate_bottom_merchants_by_invoice_count
    se = SalesEngine.from_csv(file_path)
    assert_equal 4, SalesAnalyst.new(se).bottom_merchants_by_invoice_count.count
  end

  def test_sales_analyst_can_calculate_top_days_by_invoice_count
    se = SalesEngine.from_csv(file_path)
    assert_equal ["Wednesday"], SalesAnalyst.new(se).top_days_by_invoice_count
  end

  def test_sales_analyst_can_calculate_percentage_of_invoices_that_are_shipped_pending_returned
    se = SalesEngine.from_csv(file_path)
    assert_equal 29.55, SalesAnalyst.new(se).invoice_status(:pending)
    assert_equal 56.95, SalesAnalyst.new(se).invoice_status(:shipped)
    assert_equal 13.5, SalesAnalyst.new(se).invoice_status(:returned)
  end

  def test_sales_analyst_can_find_total_revenue_by_date
    se = SalesEngine.from_csv(file_path)
    expected = BigDecimal.new('0.0', 9)
    assert_equal expected, SalesAnalyst.new(se).total_revenue_by_date(Time.parse("2012-03-27"))
  end

  def test_sales_analyst_can_find_total_revenue_by_merchant_id
    se = SalesEngine.from_csv(file_path)
    expected = BigDecimal.new('0.11639397E6',18)
    assert_equal expected, SalesAnalyst.new(se).revenue_by_merchant(12334871)
  end

  def file_path
    {
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
      }
  end
end
