require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa, :se
  def setup
    files = ({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    @se = SalesEngine.from_csv(files)
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, setup
  end

  def test_it_averages_items_per_merchant
    assert_equal 2.88, setup.average_items_per_merchant
  end

  def test_item_count_for_merchants
    assert_equal 475, setup.counts_per_merchant(se.method(:find_merchant_items)).count
  end

  def test_item_count_for_merchants_from_fixture
    # files = ({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    # @se = SalesEngine.from_csv(files)
    # @sa = SalesAnalyst.new(se)

    assert_instance_of Array, setup.counts_per_merchant(se.method(:find_merchant_items))
    assert_equal 3, setup.counts_per_merchant(se.method(:find_merchant_items))[0]
  end

  def test_item_count_subtracts_from_average_items
    assert_equal -1.88, setup.variance_of_items[1]
  end

  def test_it_squares
    assert_instance_of Array, setup.squared
  end

  def test_it_sums_array
    assert_equal 5034.92, setup.sum_array
  end

  def test_it_std_deviates
    assert_equal 3.26, setup.average_items_per_merchant_standard_deviation
  end
end
