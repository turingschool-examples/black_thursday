require 'bigdecimal'
require './test/test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'
require 'pry'


class SalesAnalystTest < MiniTest::Test

  def test_that_se_is_initialized
    se = SalesEngine.from_csv({
        :items => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices => "./data/invoices.csv"
      })
    sa = SalesAnalyst.new(se)

    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_for_standard_deviation_on_items
    se = SalesEngine.from_csv({
        :items => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices => "./data/invoices.csv"
      })
    sa = SalesAnalyst.new(se)

    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation

  end

  def test_merchants_with_high_item_count
    se = SalesEngine.from_csv({
        :items => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices => "./data/invoices.csv"
      })
    sa = SalesAnalyst.new(se)

    assert_equal 52, sa.merchants_with_high_item_count.length
  end

  def test_average_item_price_for_merchant
    se = SalesEngine.from_csv({
        :items => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices => "./data/invoices.csv"
      })
    sa = SalesAnalyst.new(se)

    assert_equal 16.66, sa.average_item_price_for_merchant(12334105)
    assert_instance_of BigDecimal, sa.average_item_price_for_merchant(12334105)
  end

  def test_average_average_price_per_merchant
    # require "pry"; binding.!
    # skip
    se = SalesEngine.from_csv({
        :items => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices => "./data/invoices.csv"
      })
    sa = SalesAnalyst.new(se)


    assert_equal 350.29, sa.average_average_price_per_merchant
  end

  def test_golden_items
    # skip
    se = SalesEngine.from_csv({
        :items => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices => "./data/invoices.csv"
      })
      sa = SalesAnalyst.new(se)

    assert_equal 5, sa.golden_items.length
  end

end
