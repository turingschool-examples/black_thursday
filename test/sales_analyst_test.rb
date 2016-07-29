require './test/test_helper'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  def test_it_has_a_sales_engine
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    sa = SalesAnalyst.new(se)
    assert sa.sales_engine.is_a?(SalesEngine)
  end

  def test_it_can_find_all_merchants
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    sa = SalesAnalyst.new(se)
    assert_equal 100, sa.all_merchants.length
  end

  def test_it_can_find_all_items
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv" })
    sa = SalesAnalyst.new(se)
    assert_equal 20, sa.all_items.length
  end

  def test_it_can_find_all_invoices
    se = SalesEngine.from_csv({ items: "./test/samples/item_sample.csv", merchants: "./test/samples/merchants_sample.csv", invoices: "./test/samples/invoices_sample.csv" })
    sa = SalesAnalyst.new(se)
    assert_equal 100, sa.all_invoices.length
  end

end
