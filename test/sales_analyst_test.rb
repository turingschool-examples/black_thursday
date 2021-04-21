require_relative 'test_helper'
require_relative '../lib/sales_engine.rb'
require_relative '../lib/sales_analyst.rb'

class SalesAnalystTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({:merchants => "./data/merchants_tiny.csv", :items => "./data/items_tiny.csv"})
    sa = se.analyst
    assert_instance_of SalesAnalyst, sa
  end

  def test_import_merchants_and_items
   se = SalesEngine.from_csv({:merchants => "./data/merchants_tiny.csv", :items => "./data/items_tiny.csv"})
   assert_equal 475, se.merchants.all.count
   assert_equal 1367, se.items.all.count
  end

  def test_average_items_per_merchant
    se = SalesEngine.from_csv({:merchants => "./data/merchants_tiny.csv", :items => "./data/items_tiny.csv"})
    sa = se.analyst
    actual = sa.average_items_per_merchant
    expected = 2.88
    assert_equal expected, actual
  end

  def test_merchant_stock_and_total_inventory
    se = SalesEngine.from_csv({:merchants => "./data/merchants_tiny.csv", :items => "./data/items_tiny.csv"})
    sa = se.analyst
    assert_equal 475, sa.merchant_stock.count
    assert_equal 475, sa.total_inventory.count
  end

  def test_average_items_per_merch_standard_deviation
    se = SalesEngine.from_csv({:merchants => "./data/merchants_tiny.csv", :items => "./data/items_tiny.csv"})
    sa = se.analyst
    actual = sa.average_items_per_merchant_standard_deviation
    expected = 3.26
    assert_equal expected, actual
  end

  def test_merchants_with_high_item_count
    se = SalesEngine.from_csv({:merchants => "./data/merchants_tiny.csv", :items => "./data/items_tiny.csv"})
    sa = se.analyst
    sa.average_items_per_merchant_standard_deviation
    found = sa.merchants_with_high_item_count
    actual = found.count
    expected = 52
    assert_equal expected, actual
  end

  def test_prices
    se = SalesEngine.from_csv({:merchants => "./data/merchants_tiny.csv", :items => "./data/items_tiny.csv"})
    sa = se.analyst
    actual = sa.prices.count
    expected = 1367
    assert_equal expected, actual
  end

  def test_average_item_price_for_merchant
    se = SalesEngine.from_csv({:merchants => "./data/merchants_tiny.csv", :items => "./data/items_tiny.csv"})
    sa = se.analyst
    actual = sa.average_item_price_for_merchant(12334105).to_f
    expected = 16.66
    assert_equal expected, actual
  end

  def test_average_average_price_per_merchant
    se = SalesEngine.from_csv({:merchants => "./data/merchants_tiny.csv", :items => "./data/items_tiny.csv"})
    sa = se.analyst
    actual = sa.average_average_price_per_merchant
    expected = 350.29
    assert_equal expected, actual
  end

  def test_price_standard_deviation
    se = SalesEngine.from_csv({:merchants => "./data/merchants_tiny.csv", :items => "./data/items_tiny.csv"})
    sa = se.analyst
    actual = sa.price_standard_deviation
    expected = 2900.99
    assert_equal expected, actual
  end

  def test_golden_items
    se = SalesEngine.from_csv({:merchants => "./data/merchants_tiny.csv", :items => "./data/items_tiny.csv"})
    sa = se.analyst
    actual = sa.golden_items.count
    expected = 5
    assert_equal expected, actual
  end

  def test_average_invoices_per_merchant
    se = SalesEngine.from_csv({:merchants => "./data/merchants_tiny.csv", :items => "./data/items_tiny.csv", :invoices => "./data/invoices_tiny.csv"})
    sa = se.analyst
    actual = sa.average_invoices_per_merchant
    expected = 1.05
    assert_equal expected, actual
  end

  def test_top_merchants_by_invoice_count
    se = SalesEngine.from_csv({:merchants => "./data/merchants_tiny.csv", :items => "./data/items_tiny.csv", :invoices => "./data/invoices_tiny.csv"})
    sa = se.analyst
    actual = sa.top_merchants_by_invoice_count.count
    expected = 39
    assert_equal expected, actual
  end

  def test_total_revenue_by_date
    se = SalesEngine.from_csv({:merchants => "./data/merchants_tiny.csv", :items => "./data/items_tiny.csv", :invoices => "./data/invoices_tiny.csv", :invoice_items => "./data/invoice_items_tiny.csv"})
    sa = se.analyst
    actual = sa.total_revenue_by_date(Time.parse("2009-02-07"))
    assert_equal 21067.77, actual
    assert_equal BigDecimal, actual.class
  end

  def test_top_revenue_earners
    skip
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv", :merchants => "./data/merchants.csv", :items => "./data/items.csv", :invoices => "./data/invoices.csv", :invoice_items => "./data/invoice_items.csv"})
    sa = se.analyst
    earners = sa.top_revenue_earners(10)
    actual = earners.count
    expected = 10
    assert_equal expected, actual
  end

end
