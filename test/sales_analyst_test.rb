require 'bigdecimal'
require './test/test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'
require 'pry'


class SalesAnalystTest < MiniTest::Test


  def test_that_se_is_initialized
    se = SalesEngine.from_csv({
    :items     => "./test/data/items_fixture.csv",
    :merchants => "./test/data/merchants_fixture.csv"
    })
    sa = SalesAnalyst.new(se)
    assert_instance_of SalesAnalyst, sa
  end

  def test_that_se_is_initialized
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"})
    sa = SalesAnalyst.new(se)

    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_for_standard_deviation_on_items
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"})
    sa = SalesAnalyst.new(se)

    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation

  end

  def test_merchants_with_high_item_count
    # skip
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"})
    sa = SalesAnalyst.new(se)

    assert_equal 0, sa.merchants_with_high_item_count.length
  end

end
