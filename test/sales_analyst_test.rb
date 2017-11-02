require_relative 'test_helper'
require './lib/sales_analyst'
require 'pry'
require 'csv'

class SalesAnalystTest < Minitest:: Test
  def test_it_exists
    se= SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture_5lines.csv",
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_instance_of SalesAnalyst, sa

  end

  def test_it_retrieves_average_items_per_merchant
    se= SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture_5lines.csv",
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal 4.514522821576763, sa.average_items_per_merchant
  end

  def test_it_retrieves_average_items_per_merchant_standard_deviation

    se= SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture_5lines.csv",
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal 15.105290456431536, sa.average_items_per_merchant_standard_deviation
  end
  def test_it_perform_standard_deviation

    se= SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture_5lines.csv",
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal 3.8865525155890452, sa.standard_deviation
  end
  def test_it_retrieves_merchants_with_high_item_count
    se= SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture_5lines.csv",
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal 15, sa.merchants_having_high_item_count.count
  end

  def test_it_retrieves_average_item_price_for_merchant
    se= SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture_5lines.csv",
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal  0.32e4, sa.average_item_price_fo_merchant(12334159)
  end

  def test_it_retrieves_average_average_price_per_merchant
    se= SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture_5lines.csv",
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal  0.53700191e5, sa.average_average_price_per_merchant
  end

  def test_it_retrieves_golden_items
skip
    se= SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture_5lines.csv",
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })
    sa = SalesAnalyst.new(se)
    golden_items = sa.golden_items.map {|item|item.name}
    golden_items= golden_items.unit_price

    assert_equal 2, golden_items
  end
end
