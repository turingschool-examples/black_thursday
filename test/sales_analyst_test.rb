require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test 

  attr_reader :engine, :analyst

  def setup
    @engine = SalesEngine.new
    engine.from_file({:items => './test/assets/medium_items.csv', :merchants => './test/assets/medium_merchants.csv'})
    @analyst =  SalesAnalyst.new(engine)
  end

  def test_engine_is_accessible_from_analyst
    assert_equal 22, analyst.engine.merchants.all.count
  end

  def test_analyst_returns_average_items_per_merchant
    assert_equal 1.73, analyst.average_items_per_merchant.round(2)
  end

  def test_analyst_returns_average_items_per_merchant_standard_deviation
    assert_equal 1.09, analyst.average_items_per_merchant_standard_deviation.round(2)
  end

  def test_that_stdev_method_works
    array = [13, 22, 23, 50]
    expected = 13.84
    assert_equal expected, analyst.stdev(array).round(2)
  end

  def test_it_averages_arrays
    array = [13, 22, 23, 50]
    assert_equal 27, analyst.find_average(array)
  end

  def test_it_returns_high_item_count
    expected_array = ["Madewithgitterxx : 3", "2MAKERSMARKET : 4", "Soudoveshop : 3", "BowlsByChris : 5"]
    found_merchants = analyst.merchants_with_high_item_count.map { |merchant| "#{merchant.name} : #{merchant.items.count}"}
    assert_equal expected_array, found_merchants
  end

  def test_it_finds_average_price_of_one_merchant
    assert_equal 2400.0, analyst.average_item_price_for_merchant(12334145)
  end

  def test_analyst_finds_average_average_price_per_merchant
    assert_equal 8004.35, analyst.average_average_price_per_merchant.round(2)
  end

  def test_it_finds_golden_items_of_all_items
    golden_array = ["Introspection virginalle : 600.0", "La prière : 650.0", "Les raisons : 600.0", "Matrice monolithique : 600.0", "Monolithes à découper : 600.0"]
    found_items = analyst.golden_items.map { |item| "#{item.name} : #{item.unit_price_as_dollars}"}
    assert_equal golden_array, found_items
  end
end