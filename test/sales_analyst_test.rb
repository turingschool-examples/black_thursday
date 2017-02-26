require './test/test_helper'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items     => "./data/items_test_data.csv",
      :merchants => "./data/merchants_test_data.csv",})
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_can_return_sum_of_all_item_prices
    assert_equal 116268.99, @sa.all_prices
  end

  def test_can_return_array_of_all_merchant_ids
    assert_equal 14, @sa.all_merchants.count
    assert_equal 12334105, @sa.all_merchants.first
  end

  def test_can_build_hash_of_merchants_and_prices
    merchant_hash = @sa.build_hash
    assert_equal 14, merchant_hash.count
    assert_equal [[12334105, [29.99]], [12334112, [15.0]], [12334113, [150.0]]], merchant_hash.take(3)

  end

  def test_can_return_all_prices_of_single_merchant
    results = @sa.get_prices_of_merchant(12334145)
    assert_equal [[12334145, [30.0, 25.0, 25.0, 20.0]]], results
  end

  def test_average_items_per_merchant
    results = @sa.average_items_per_merchant
    assert_equal 1.79, results
  end

end
