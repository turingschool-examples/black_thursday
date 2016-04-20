require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  attr_reader :merch_repo, :se, :sa

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/small_items.csv",
      :merchants => "./data/small_merchants.csv",})
    @sa = SalesAnalyst.new(se)
    @se.merchants
    @se.items
    @merch_repo = @se.merchant_repo
  end

  def test_average_items_per_merchant_gives_correct_average
    assert_equal 1.90, sa.average_items_per_merchant
  end

  def test_sum_can_sum_array
    assert_equal 6, sa.sum([1,2,3])
  end

  def test_average_an_array
    assert_equal 2, sa.average([1,2,3])
  end

  def test_standard_deviation_works_on_an_array
    assert_equal 1.0, sa.standard_deviation([1,2,3])
    assert_equal 2.65, sa.standard_deviation([1,2,6])
  end


end
