require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < MiniTest::Test

  def test_it_exists
    se = SalesEngine.new({merchants:"./data/merchants.csv",
    items:"./data/items.csv",
    invoices:"./data/invoices.csv"})
    sa = SalesAnalyst.new(se)

    assert_instance_of SalesEngine, se
    assert_instance_of SalesAnalyst, sa
  end

  def test_average_items_per_merchant
    se = SalesEngine.new({merchants:"./data/merchants.csv",
    items:"./data/items.csv",
    invoices:"./data/invoices.csv"})
    sa = SalesAnalyst.new(se)

    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    se = SalesEngine.new({merchants:"./data/merchants.csv",
    items:"./data/items.csv",
    invoices:"./data/invoices.csv"})
    sa = SalesAnalyst.new(se)

    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    se = SalesEngine.new({merchants:"./data/merchants.csv",
    items:"./data/items.csv",
    invoices:"./data/invoices.csv"})
    sa = SalesAnalyst.new(se)

    assert_equal 52, sa.merchants_with_high_item_count.count
  end

  def test_average_item_price_for_merchant
    se = SalesEngine.new({merchants:"./data/merchants.csv",
    items:"./data/items.csv",
    invoices:"./data/invoices.csv"})
    sa = SalesAnalyst.new(se)

    assert_equal 0.1666e2, sa.average_item_price_for_merchant(12334105)
  end

  def test_average_average_price_for_merchant
    se = SalesEngine.new({merchants:"./data/merchants.csv",
    items:"./data/items.csv",
    invoices:"./data/invoices.csv"})
    sa = SalesAnalyst.new(se)

    assert_equal 350.29, sa.average_average_price_per_merchant
  end
end
