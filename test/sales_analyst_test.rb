require_relative 'test_helper'
require './lib/sales_analyst.rb'
require 'pry'

class SalesAnalystTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert @sa
  end

  def test_it_knows_parent
    refute @sa.sales_engine.nil?
  end
  
  def test_it_can_find_the_standard_deviation
    result = @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_calculates_average_per_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_calculates_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_it_can_calculate_average_item_price
    assert_equal 16.66, @sa.average_item_price_for_merchant(12334105)
    assert_equal 33.5, @sa.average_item_price_for_merchant(12334871)
  end

  def test_it_calculates_average_average_price
    assert_equal 350.29, @sa.average_average_price_per_merchant
  end

  def test_average_method_averages
    assert_equal 2, @sa.average([1,2,3])
  end

end