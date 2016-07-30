require './test/test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def sales_analyst_test_setup
    se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                :merchants => "./data/merchants.csv" })
    SalesAnalyst.new(se)
  end

  def test_it_creates_sales_analyst_with_a_sales_engine
    sa = sales_analyst_test_setup

    assert_instance_of SalesAnalyst, sa
  end

  def test_it_calculates_average_items_per_merchant
    sa = sales_analyst_test_setup

    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_it_calculates_items_per_merchant
    se_sample = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./test/fixtures/merchants_sample.csv" })
    sa_sample = SalesAnalyst.new(se_sample)

    assert_equal [3, 1, 1, 1, 25, 3, 1, 1, 1, 7], sa_sample.items_per_merchant
  end

  def test_it_calculates_average_items_per_merchant_standard_deviation
    sa = sales_analyst_test_setup

    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_calculates_which_merchants_sell_the_most_items
    sa = sales_analyst_test_setup

    assert_equal 52, sa.merchants_with_high_item_count.count
    assert_instance_of Merchant, sa.merchants_with_high_item_count.first
    ##is there a more valid way to test this?
  end

  def test_it_calculates_the_average_price_of_merchants_items
    sa = sales_analyst_test_setup

    assert_equal 20, sa.average_item_price_for_merchant(12334115)
    assert_equal 35, sa.average_item_price_for_merchant(12334132)
    assert_equal 12, sa.average_item_price_for_merchant(12334141)
  end

  def test_it_calculates_the_average_of_the_average_price_of_all_merchants_items
    sa = sales_analyst_test_setup

    assert_equal 350.29, sa.average_average_price_per_merchant
  end

  def test_it_calculates_average_item_price
    sa = sales_analyst_test_setup

    assert_equal 251.06, sa.average_item_price
  end

  def test_it_calculates_item_price_standard_deviation
    sa = sales_analyst_test_setup

    assert_equal 2900.99, sa.item_price_standard_deviation
  end

  def test_it_returns_highest_priced_items
    sa = sales_analyst_test_setup

    assert_equal 5, sa.golden_items.count
    assert_instance_of Item, sa.golden_items.first
    ##is there a more valid way to test this?
  end
end
