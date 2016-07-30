require './test/test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def test_it_creates_sales_analyst_with_a_sales_engine
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv" })
    sa = SalesAnalyst.new(se)

    assert_instance_of SalesAnalyst, sa
  end

  def test_it_calculates_average_items_per_merchant
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv" })
    sa = SalesAnalyst.new(se)

    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_it_calculates_items_per_merchant
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./test/fixtures/merchants_sample.csv" })
    sa = SalesAnalyst.new(se)

    assert_equal [3, 1, 1, 1, 25, 3, 1, 1, 1, 7], sa.items_per_merchant
  end

  def test_it_calculates_average_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv" })
    sa = SalesAnalyst.new(se)

    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_calculates_which_merchants_sell_the_most_items
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv" })
    sa = SalesAnalyst.new(se)

    assert_equal 52, sa.merchants_with_high_item_count.count
    assert_instance_of Merchant, sa.merchants_with_high_item_count.first
    ##is there a more valid way to test this?
  end

  def test_it_calculates_the_average_price_of_merchants_items
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv" })
    sa = SalesAnalyst.new(se)

    assert_equal 20, sa.average_item_price_for_merchant(12334115)
    assert_equal 35, sa.average_item_price_for_merchant(12334132)
    assert_equal 12, sa.average_item_price_for_merchant(12334141)
  end

  # def test_it_calculates_the_sum_of_the_average_price_of_a_merchants_items
  #   se = SalesEngine.from_csv({ :items     => "./data/items.csv",
  #                               :merchants => "./data/merchants.csv" })
  #   sa = SalesAnalyst.new(se)
  #
  #   assert_equal 0, sa.average_average_price_per_merchant
  # end
end
