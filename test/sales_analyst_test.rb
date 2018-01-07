require_relative 'test_helper'
require_relative '../lib/sales_analyst'


class SalesAnalystTest < Minitest::Test

  attr_reader :sales_analyst

  def setup
    @se = SalesEngine.new({
      :items     => "./test/fixtures/items_sample.csv",
      :merchants => "./test/fixtures/merchants_sample.csv",
    })
    @sales_analyst = SalesAnalyst.new(@se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_it_returns_average
    skip
    assert_equal 3.43, sales_analyst.average_items_per_merchant
    refute_equal 0.43, sales_analyst.average_items_per_merchant
  end

  def test_it_returns_standard_deviation
    skip
    assert_equal 0.38, sales_analyst.average_items_per_merchant_standard_deviation
    refute_equal 1.38, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_returns_array_of_item_totals_for_merchants
    skip
    assert_equal 7, sales_analyst.number_of_items_per_merchant.count
    refute_equal 4, sales_analyst.number_of_items_per_merchant.count
  end

  def test_it_returns_merchants_with_highest_item_count
    skip
    assert_equal 7, sales_analyst.merchants_with_high_item_count.count
    refute_equal 10, sales_analyst.merchants_with_high_item_count.count
  end

  def test_it_returns_average_price_of_merchants_items
    skip
    assert_equal 0.2999e4, sales_analyst.average_item_price_for_merchant(12334105)
  end

  def test_it_returns_average_price_of_all_merchants_items
    skip
    assert_equal 0.2999e4, sales_analyst.average_price_for_all_merchants
  end

  # def test_it_returns_golden_items
  #   assert_equal 6, sales_analyst.golden_items.count
  #   refute_equal 10, sales_analyst.golden_items.count
  #   assert_instance_of Item, sales_analyst.golden_items.first
  # end


end
