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

  def test_generates_array_of_item_counts_by_merchant

    assert_equal  [1, 1, 1, 1, 1, 1, 2, 2, 3, 6], sa.item_count_by_merchant
  end

  def test_calculates_sd_array_of_item_counts_by_merchant
    assert_equal 1.60, sa.standard_deviation(sa.item_count_by_merchant)
  end

  def test_identifes_all_merchant_with_high_item_counts
    assert_equal 1, sa.merchant_with_high_item_count.length
  end

  def test_identifes_corrent_merchant_with_high_item_counts
    assert_equal 12334185, sa.merchant_with_high_item_count[0].id
  end

  def test_identifies_average_item_price_for_merchant
    assert_equal  50.0, sa.average_item_price_for_merchant(12334144)
  end

  def test_identifies_average_item_price_for_merchant_as_BD
    assert_equal  BigDecimal, sa.average_item_price_for_merchant(12334144).class
  end

  def test_identifies_avg_avg_price_per_merchant_as_BD
    assert_equal  BigDecimal, sa.average_average_price_per_merchant.class
  end

  def test_identifies_avg_avg_price_for_merchant
    #failing but not off by much
    assert_equal  72.91, sa.average_average_price_per_merchant.to_f
  end

  def test_generates_array_of_item_prices
    sorted = [3.99, 6.9, 7.0, 9.99, 13.0, 13.0, 14.0, 14.9, 20.0, 29.99, 35.0, 49.0, 75.0, 80.0, 120.0, 130.0, 149.0, 150.0, 400.0]
    assert_equal  sorted, sa.item_price_array
  end

  def test_calculates_std_dev_of_item_prices
    assert_equal 94.90, sa.item_price_standard_deviation
  end

  def test_average_item_price
    assert_equal 69.51, sa.item_price_average
  end

  def test_identifes_all_golden_items
    assert_equal 1, sa.golden_items.length
  end

  def test_identifes_correct_golden_item
    assert_equal 263396517, sa.golden_items[0].id
  end

end
