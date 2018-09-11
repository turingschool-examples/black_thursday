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
    assert_equal 2.88, sa.average_items_invoices_per_merchant(sa.item_repo)
  end

  def test_it_can_get_array_of_items_per_merchant
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_equal 475, sa.items_per_merchant_array(sa.item_repo).length
  end

  def test_it_can_take_difference_between_a_set_and_mean_and_square_it
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_equal 5034.919999999962, sa.subtract_square_sum_array_for_items_per_merchant(sa.item_repo)
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
    assert_equal 3.26, sa.per_merchant_standard_deviation(sa.item_repo)
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
    skip
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_equal 52, sa.merchants_with_high_item_count.count
  end

  def test_it_can_return_average_item_price_per_merchant
    skip
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_instance_of BigDecimal, sa.average_item_price_for_merchant(12334105)
    assert_equal 16.66 , sa.average_item_price_for_merchant(12334105)
  end

  def test_it_can_find_the_global_average
    skip
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_instance_of BigDecimal, sa.average_average_price_per_merchant
    assert_equal 350.29 , sa.average_average_price_per_merchant
  end

  def test_it_can_find_golden_items
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
      })
    sa = se.analyst
    assert_equal 5, sa.golden_items.count
  end

  def test_it_can_average_invoices_per_merchant
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices => "./data/invoices.csv"
      })
    sa = se.analyst
    assert_equal 10.49, sa.average_items_invoices_per_merchant(sa.invoice_repo)
  end
end
