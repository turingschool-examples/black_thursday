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

  def test_average_items_per_merch_std
    se = SalesEngine.from_csv({:merchants => "./data/merchants.csv", :items => "./data/items.csv"})
    sa = se.analyst
    actual = sa.average_items_per_merchant_standard_deviation
    expected = 3.26
    assert_equal expected, actual
  end

  def average_invoices_per_merchant

  end

  def top_merchants_by_invoice_count

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
    
  end

  def test_average_price_per_merchant

  end

  def test_item_price_standard_deviation

  end

  def test_golden_items

  end
end
