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
    skip
    se= SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture_5lines.csv",
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal 2, sa.average_item_price_for_merchant(id)
  end
  def test_it_retrieves_average_average_price_per_merchant
    skip
    se= SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture_5lines.csv",
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal 2, sa.average_average_price_per_merchant
  end
  def test_it_retrieves_golden_items
    skip
    se= SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture_5lines.csv",
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal 2, sa.golden_items
  end



end
