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

  def test_it_can_find_the_number_of_items_per_marchant
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    sa = SalesAnalyst.new(se)

    assert_equal 3, sa.total_items_per_merchant("12334185")
  end

  def test_it_can_find_total_number_of_merchants
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    sa = SalesAnalyst.new(se)

    assert_equal 100, sa.total_merchants.length
  end

  def test_it_can_find_the_total_number_of_items
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    sa = SalesAnalyst.new(se)

    assert_equal 20, sa.total_items.length
  end

  def test_it_can_find_the_average_items_per_merchant
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    sa = SalesAnalyst.new(se)

    assert_equal 0.2, sa.average_items_per_merchant
  end

  def test_it_can_put_items_per_merchant_id_into_an_array
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    sa = SalesAnalyst.new(se)

    assert sa.set.is_a?(Array)
  end

  def test_it_can_store_correct_number_of_items_per_merchant_id
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    sa = SalesAnalyst.new(se)

    assert_equal 100, sa.set.length
  end

  def test_standard_deviation_returns_a_float
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    sa = SalesAnalyst.new(se)

    assert sa.average_items_per_merchant_standard_deviation.is_a?(Float)
  end

  def test_it_can_calculate_standard_deviation
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    sa = SalesAnalyst.new(se)

    assert_equal 0.83, sa.average_items_per_merchant_standard_deviation
  end







end
