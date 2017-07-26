require 'bigdecimal'
require './test/test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'
require 'csv'
require 'pry'


class SalesAnalystTest < MiniTest::Test


  def test_that_se_is_initialized
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    sa = SalesAnalyst.new(se)
    assert_instance_of SalesAnalyst, sa
  end

  def test_that_se_is_initialized
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    sa = SalesAnalyst.new(se)

    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    sa = SalesAnalyst.new(se)

    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    sa = SalesAnalyst.new(se)

    assert_equal 3, sa.merchants_with_high_item_count.length
  end

end
