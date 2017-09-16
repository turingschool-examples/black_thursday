require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'
require 'bigdecimal'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa
  def set_up
    files = ({:items => "./test/fixtures/item_fixture.csv", :merchants => "./test/fixtures/merchant_fixture.csv"})
    se = SalesEngine.from_csv(files)
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    set_up

    assert_instance_of SalesAnalyst, sa
  end

  def test_average_items_per_merchant
    set_up

    assert_equal 0.83, sa.average_items_per_merchant
  end

  def test_find_averages
    set_up

    assert_equal 6, sa.find_all_averages_by_merchant.count
  end

  def test_standard_deviation
    files = ({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    se = SalesEngine.from_csv(files)
    sales_a = SalesAnalyst.new(se)

    assert_equal 3.26, sales_a.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    files = ({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    se = SalesEngine.from_csv(files)
    sales_a = SalesAnalyst.new(se)

    assert_equal 52, sales_a.merchants_with_high_item_count.count
  end

  def test_average_item_price_for_merchant
    files = ({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    se = SalesEngine.from_csv(files)
    sales_a = SalesAnalyst.new(se)

    assert_equal  0.315e2, sales_a.average_item_price_for_merchant(12334159)
  end

  def test_average_average_price_per_merchant
    files = ({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    se = SalesEngine.from_csv(files)
    sales_a = SalesAnalyst.new(se)

    assert_equal BigDecimal.new('0.350294697495132463357977937150568421052631578947e3'), sales_a.average_average_price_per_merchant
  end

  def test_average_item_price
    set_up

    assert_equal 0.15098e2, sa.average_item_price
  end

  def test_standard_deviation_of_item_price
    set_up

    assert_equal 8.72, sa.std_deviation_of_item_price
  end

  def test_golden_items
    set_up

    assert_equal 1, sa.golden_items.count
  end
end
