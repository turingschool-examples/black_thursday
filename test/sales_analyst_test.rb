require 'minitest/autorun'
require 'minitest/emoji'
require 'csv'
require 'bigdecimal'
require './lib/sales_analyst'


class SalesAnalystTest < Minitest::Test
  attr_reader :sales_engine
  def setup
    @sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"})
  end

  def test_it_exists
    sa = SalesAnalyst.new(sales_engine)
    assert_equal SalesAnalyst, sa.class
  end

  def test_it_connects_with_sales_engine
    sa = SalesAnalyst.new(sales_engine)
    assert_equal Class, sa.se.class
  end

  def test_it_can_find_items_per_merchant
  #something is screwed up here, too
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 1, sa.items_per_merchant(12334301)
    assert_equal 2, sa.items_per_merchant(12334269)
    assert_equal 3, sa.items_per_merchant(12336957)
  end

  def test_it_can_find_average_items_per_merchant
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_it_creates_all_merchant_ids
    sa = SalesAnalyst.new(sales_engine)
    result = sa.create_all_merchant_ids
    assert_equal 475, result.length
  end

  def test_it_can_find_average_item_price_per_merchant
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 18.98, sa.average_item_price_per_merchant(12336957)
  end

  def test_it_can_find_items_per_merchant_standard_deviation
    #something is screwed up here
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 238, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_find_average_item_price_for_all_merchants
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 35.03, sa.average_price_per_item
  end

  def test_it_can_find_golden_items
    sa = SalesAnalyst.new(sales_engine)
    assert_equal "Test listing", sa.golden_items.first.name
  end

  def test_it_can_find_invoices_per_merchant
  #something is screwed up here
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 1, sa.invoices_per_merchant(12334404)
    assert_equal 2, sa.invoices_per_merchant(12334570)
    assert_equal 3, sa.invoices_per_merchant(12334488)
    assert_equal 4, sa.invoices_per_merchant(12335073)
    assert_equal 1, sa.invoices_per_merchant(12334301)
  end

  def test_it_can_find_average_invoices_per_merchant
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 10.49, sa.average_invoices_per_merchant
  end

  def test_it_can_find_invoices_per_merchant_standard_deviation
    #something is screwed up here, too, probably has to do with the invoices/items per merchant problem
    sa = SalesAnalyst.new(sales_engine)
    assert_equal 238, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_it_can_find_invoice_status
    skip
    sa = SalesAnalyst.new(sales_engine)
  end

  def test_it_can_find_top_merchants_by_invoice_count
    skip
  end

  def test_it_can_find_bottom_merchants_by_invoice_count
    skip
  end

end