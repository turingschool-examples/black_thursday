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

  def test_invoice_total
    skip
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv", :merchants => "./data/merchants.csv", :items => "./data/items.csv", :invoices => "./data/invoices.csv", :invoice_items => "./data/invoice_items.csv"})
    sa = se.analyst
    actual = sa.invoice_total(3485)
    assert_equal 28597.08, actual
    assert_equal BigDecimal, actual.class
  end

  def test_total_revenue_by_date
    skip
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv", :merchants => "./data/merchants.csv", :items => "./data/items.csv", :invoices => "./data/invoices.csv", :invoice_items => "./data/invoice_items.csv"})
    sa = se.analyst
    actual = sa.total_revenue_by_date(Time.parse("2009-02-07"))
    assert_equal 21067.77, actual
    assert_equal BigDecimal, actual.class
  end

  def test_total_pending_invoices
    skip
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv", :merchants => "./data/merchants.csv", :items => "./data/items.csv", :invoices => "./data/invoices.csv", :invoice_items => "./data/invoice_items.csv"})
    sa = se.analyst
    actual = sa.pending_invoices
    assert_equal 2175, actual.count
    assert_equal Array, actual.class
  end

  def test_merchants_with_pending_invoices
    skip
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv", :merchants => "./data/merchants.csv", :items => "./data/items.csv", :invoices => "./data/invoices.csv", :invoice_items => "./data/invoice_items.csv"})
    sa = se.analyst
    actual = sa.merchants_with_pending_invoices
    assert_equal 467, actual.count
    assert_equal Array, actual.class
  end

  def test_merchants_with_pending_invoices
    skip
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv", :merchants => "./data/merchants.csv", :items => "./data/items.csv", :invoices => "./data/invoices.csv", :invoice_items => "./data/invoice_items.csv"})
    sa = se.analyst
    actual = sa.merchants_with_only_one_item
    assert_equal 243, actual.count
    assert_equal Array, actual.class
  end

  def test_revenue_by_merchant
    skip
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv", :merchants => "./data/merchants.csv", :items => "./data/items.csv", :invoices => "./data/invoices.csv", :invoice_items => "./data/invoice_items.csv"})
    sa = se.analyst
    actual = sa.revenue_by_merchant(12334194)
    assert_equal 81572.40, actual.to_f.round(2)
    assert_equal BigDecimal, actual.class
  end

  def test_top_revenue_earners
    skip
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv", :merchants => "./data/merchants.csv", :items => "./data/items.csv", :invoices => "./data/invoices.csv", :invoice_items => "./data/invoice_items.csv"})
    sa = se.analyst
    earners = sa.top_revenue_earners
    assert_equal 20, earners.count
    assert_equal 12334159, earners.last.id
  end

  def test_valid_transactions
    skip
    se = SalesEngine.from_csv({:transactions => "./data/transactions_tiny.csv", :merchants => "./data/merchants_tiny.csv", :items => "./data/items_tiny.csv", :invoices => "./data/invoices_tiny.csv", :invoice_items => "./data/invoice_items_tiny.csv"})
    sa = se.analyst
    actual = sa.valid_transactions(se.invoices.all)
    assert_equal 4, actual.count
    assert_equal Array, actual.class
  end


  def test_valid_invoice_items
    skip
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv", :merchants => "./data/merchants.csv", :items => "./data/items.csv", :invoices => "./data/invoices.csv", :invoice_items => "./data/invoice_items.csv"})
    sa = se.analyst
    actual = sa.most_sold_item_for_merchant(12334189)
    assert_equal 9, actual.count
    assert_equal Array, actual.class
  end

  def test_most_sold_item_for_merchant
    se = SalesEngine.from_csv({:transactions => "./data/transactions.csv", :merchants => "./data/merchants.csv", :items => "./data/items.csv", :invoices => "./data/invoices.csv", :invoice_items => "./data/invoice_items.csv"})
    sa = se.analyst
    actual = sa.most_sold_item_for_merchant(12334189)
    assert_equal 1, actual.count
    assert_equal Array, actual.class
  end

  # def test_matched_invoices
  #   skip
  #   se = SalesEngine.from_csv({:transactions => "./data/transactions.csv", :merchants => "./data/merchants.csv", :items => "./data/items.csv", :invoices => "./data/invoices.csv", :invoice_items => "./data/invoice_items.csv"})
  #   sa = se.analyst
  #   actual = sa.matched_invoices[328]
  #   expected = 12337193
  #   assert_equal expected, actual
  # end

end
