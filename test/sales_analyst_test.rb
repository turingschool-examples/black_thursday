require './test/test_helper'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  def test_it_has_a_sales_engine
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    sa = SalesAnalyst.new(se)
    assert sa.sales_engine.is_a?(SalesEngine)
  end

  def test_it_can_find_all_merchants
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    sa = SalesAnalyst.new(se)
    assert_equal 100, sa.sales_engine.merchants.all.length
  end

  def test_it_can_find_average_item_price_for_a_merchant
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    sa = SalesAnalyst.new(se)

    assert_equal BigDecimal(11.17, 4), sa.average_item_price_for_merchant("12334185")
  end

  def test_average_item_price_returns_nil_for_an_itemless_merchant
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    sa = SalesAnalyst.new(se)

    assert_equal nil, sa.average_item_price_for_merchant("12334496")
  end

  def test_average_item_price_returns_nil_for_a_nonexistent_merchant
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    sa = SalesAnalyst.new(se)

    assert_equal nil, sa.average_item_price_for_merchant("99999999")
  end

  def test_it_can_find_average_average_item_price_for_all_merchants
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    sa = SalesAnalyst.new(se)

    assert_equal BigDecimal(71.04, 4), sa.average_average_item_price_per_merchant
  end

  def test_average_average_returns_nil_with_no_merchants
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/empty_file.csv" })
    sa = SalesAnalyst.new(se)

    assert_equal nil, sa.average_average_item_price_per_merchant
  end

  def test_average_average_returns_nil_with_no_items
    se = SalesEngine.from_csv({ items: "./data/empty_file.csv", merchants: "./data/merchants_sample.csv" })
    sa = SalesAnalyst.new(se)

    assert_equal nil, sa.average_average_item_price_per_merchant
  end


end
