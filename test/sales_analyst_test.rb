require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < MiniTest::Test
  attr_reader :sa

  def setup
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_it_itializes_sales_analyst
    assert sa
  end

  def test_it_finds_number_of_items_for_each_merchant
    assert_equal 475, sa.items_per_merchant.length
  end

  def test_it_finds_average_items_per_merchant
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_it_finds_standard_deviation
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  # def test_it_finds_merchants_with_high_item_count
  #   assert_equal [], sa.merchants_with_high_item_count
  # end


end
