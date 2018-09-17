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
   assert_equal 9, se.merchants.all.count
   assert_equal 19, se.items.all.count
  end

  def test_average_items_per_merchant
    se = SalesEngine.from_csv({:merchants => "./data/merchants.csv", :items => "./data/items.csv"})
    sa = se.analyst
    actual = sa.average_items_per_merchant
    expected = 2.88
    assert_equal expected, actual
  end

  def test_average_items_per_merch_standard_deviation
    se = SalesEngine.from_csv({:merchants => "./data/merchants.csv", :items => "./data/items.csv"})
    sa = se.analyst
    actual = sa.average_items_per_merchant_standard_deviation
    expected = 3.26
    assert_equal expected, actual
  end

  def test_merchants_with_high_item_count
    se = SalesEngine.from_csv({:merchants => "./data/merchants.csv", :items => "./data/items.csv"})
    sa = se.analyst
    sa.average_items_per_merchant_standard_deviation
    found = sa.merchants_with_high_item_count
    actual = found.count
    expected = 52
    assert_equal expected, actual
  end

  def test_average_item_price_for_merchant
    se = SalesEngine.from_csv({:merchants => "./data/merchants.csv", :items => "./data/items.csv"})
    sa = se.analyst
    actual = sa.average_item_price_for_merchant(12334105)
    expected = 16.66
    assert_equal expected, actual
  end

  def test_average_average_price_per_merchant
    se = SalesEngine.from_csv({:merchants => "./data/merchants.csv", :items => "./data/items.csv"})
    sa = se.analyst
    actual = sa.average_average_price_per_merchant
    expected = 350.29
    assert_equal expected, actual
  end

  def test_prices
    se = SalesEngine.from_csv({:merchants => "./data/merchants.csv", :items => "./data/items.csv"})
    sa = se.analyst
    actual = sa.prices.count
    expected = 1367
    assert_equal expected, actual
  end

  def test_price_standard_deviation
    se = SalesEngine.from_csv({:merchants => "./data/merchants.csv", :items => "./data/items.csv"})
    sa = se.analyst
    actual = sa.price_standard_deviation
    expected = 2900.99
    assert_equal expected, actual
  end

  def test_golden_items
    se = SalesEngine.from_csv({:merchants => "./data/merchants.csv", :items => "./data/items.csv"})
    sa = se.analyst
    actual = sa.golden_items.count
    expected = 5
    assert_equal expected, actual
  end

  def average_invoices_per_merchant
    skip
    se = SalesEngine.from_csv({:merchants => "./data/merchants.csv", :items => "./data/items.csv"})
    sa = se.analyst
    actual = sa.average_invoices_per_merchant
    expected

  end

  def top_merchants_by_invoice_count
    skip
    se = SalesEngine.from_csv({:merchants => "./data/merchants.csv", :items => "./data/items.csv"})
    sa = se.analyst

  end

end
