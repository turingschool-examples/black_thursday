require_relative '../test/test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'


class SalesAnalystTest < Minitest::Test

  def test_it_can_calculate_average_items_per_merchant
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_it_can_get_array_of_items_per_merchant
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_equal 475, sa.items_per_merchant_array.length
  end

  def test_it_can_take_difference_between_a_set_and_mean_and_square_it
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_equal 5034.919999999962, sa.subtract_square_sum_array
  end

  def test_it_can_sum_array
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_equal 15, sa.sum([1, 2, 3, 4, 5])
  end

  def test_it_can_calculate_average_items_per_merchange_st_dev
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_return_a_hash_of_merchants_with_their_items
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_equal 475, sa.merchant_hash.length
  end

  def test_it_can_return_a_hash_of_merchants_and_items_above_one_stand_deviation
    skip
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert sa.merchants_with_high_item_count_hash.all? do |item_array|
      item_array.count >= 6.14
    end
  end

  def test_it_can_return_merchants_above_one_stand_deviation_in_an_array
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_equal 52, sa.merchants_with_high_item_count.count
  end
end
