require 'minitest/autorun'
require 'minitest/emoji'
require 'csv'
require 'bigdecimal'
require_relative '../lib/sales_analyst'


class SalesAnalystTest < Minitest::Test
  attr_reader :sales_engine
  def setup
    @sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/small_merchant_file.csv",
      :invoices => "./data/small_invoice_file.csv",
      :customers => "./data/small_customer_file.csv",
      :transactions => "./data/small_transaction_file.csv",
      :invoice_items => "./data/small_invoice_item_file.csv"})
  end

  def test_it_exists
    sa = SalesAnalyst.new(sales_engine)
    assert_equal SalesAnalyst, sa.class
  end

  def test_it_connects_with_sales_engine
    sa = SalesAnalyst.new(sales_engine)
    assert_equal Class, sa.se.class
  end

  def test_standard_deviation_works_on_an_array
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 1.0, sa.standard_deviation([1,2,3])
    assert_equal 2.65, sa.standard_deviation([1,2,6])
  end

  def test_generates_array_of_item_counts_per_merchant
    sa = SalesAnalyst.new(sales_engine)
    assert_equal  [3, 5, 1, 6, 25, 20, 1, 1, 1, 3], sa.items_per_merchant
  end

  def test_it_can_find_average_items_per_merchant
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 136.7, sa.average_items_per_merchant
  end

  def test_it_creates_all_merchant_ids
    sa = SalesAnalyst.new(sales_engine)
    result = sa.create_all_merchant_ids
    assert_equal 10, result.length
  end

  def test_it_can_find_average_item_price_for_merchant
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 100.0, sa.average_item_price_for_merchant(12334123)
  end

  def test_it_can_find_items_per_merchant_standard_deviation
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 6.6, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_find_average_item_price_for_all_merchants
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 91.54, sa.average_average_price_per_merchant
  end

  def test_it_can_find_merchants_with_high_item_count
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 0, sa.merchants_with_high_item_count
  end

  def test_it_can_find_golden_items
    sa = SalesAnalyst.new(sales_engine)
    assert_equal "Test listing", sa.golden_items.first.name
  end

  def test_it_can_find_average_invoices_per_merchant
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 2.0, sa.average_invoices_per_merchant
  end

  def test_it_can_find_invoices_per_merchant_standard_deviation
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 2.7, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_it_can_find_invoice_status
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 29.3, sa.invoice_status("pending")
    assert_equal 56.45, sa.invoice_status("shipped")
    assert_equal 14.25, sa.invoice_status("returned")
  end

  def test_it_can_find_top_merchants_by_invoice_count
    sa = SalesAnalyst.new(sales_engine)
    assert_equal "perlesemoi", sa.top_merchants_by_invoice_count.first.name
  end

  def test_it_can_find_bottom_merchants_by_invoice_count
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 0, sa.bottom_merchants_by_invoice_count.first.name  
  end

  # def test_it_group_invoices_by_day
  #   sa = SalesAnalyst.new(sales_engine)
  #   assert_equal [], sa.group_invoices_by_day.keys
  # end

  # def test_it_can_find_top_days_by_invoice_count
  #   sa = SalesAnalyst.new(sales_engine)
  #   assert_equal 0, sa.top_days_by_invoice_count
  # end


end