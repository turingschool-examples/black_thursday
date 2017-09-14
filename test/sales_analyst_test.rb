require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  attr_reader :se,
              :sa

  def setup
    @se = SalesEngine.from_csv({
            :items => './test/fixtures/items_truncated_10.csv',
            :merchants => './test/fixtures/merchants_truncated_4.csv',
            })
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_average_items_per_merchant_returns_average
    assert_equal 2.5, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation_returns_standard_deviation
    assert_equal 1.73, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count_returns_merchants_array
    expected = [@se.merchants.find_by_id(12334123)]
    actual = sa.merchants_with_high_item_count

    assert_equal expected, actual
  end






end
