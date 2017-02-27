require './test/test_helper'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",})
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_can_return_sum_of_all_item_prices
    assert_equal 343192.3300000002, @sa.all_prices
  end

  def test_can_return_array_of_all_merchant_ids
    assert_equal 475, @sa.all_merchants.count
  end

  def test_can_build_hash_of_merchants_and_prices
    merchant_hash = @sa.build_hash
    assert_equal 475, merchant_hash.count
    assert_equal [[12334105, [29.99, 9.99, 9.99]], [12334112, [15.0]], [12334113, [150.0]]], merchant_hash.take(3)

  end

  def test_can_return_all_prices_of_single_merchant
    results = @sa.get_prices_of_merchant(12334145)
    assert_equal [[12334145, [30.0, 25.0, 25.0, 20.0, 25.0, 25.0, 25.0]]], results
  end

  def test_average_items_per_merchant
    results = @sa.average_items_per_merchant
    assert_equal 2.88, results
  end

  def test_std_from_array
    assert_equal 3.90, @sa.std_dev_from_array([2,6,9.8])
    assert_equal 20.10, @sa.std_dev_from_array([11,4,0,0,0.45,13.5,56])
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal "Keckenbauer" , @sa.merchants_with_high_item_count.first.name
    assert_instance_of Array, @sa.merchants_with_high_item_count
  end

  def test_average_item_price_for_merchant
    assert_equal 0.315E2, @sa.average_item_price_for_merchant(12334159)
  end

  def test_average_average_price_per_merchant
    assert_equal 0.35029e3, @sa.average_average_price_per_merchant
  end

  def test_golden_items
    assert_equal 5, @sa.golden_items.count
    assert_equal "Test listing", @sa.golden_items.first.name
  end

end
