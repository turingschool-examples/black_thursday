require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  attr_reader   :sales_analyst

  def setup
    sales_engine = SalesEngine.from_csv({
    :items => "./fixture/items.csv",
    :merchants => "./fixture/merchant_test_file.csv"
    })
    @sales_analyst = SalesAnalyst.new(sales_engine)
  end

  def test_it_can_create_sales_analyst
    assert sales_analyst
  end

  def test_it_has_a_sales_engine_instance
    assert_instance_of SalesEngine, sales_analyst.sales_engine
  end

  def test_it_can_return_total_number_of_items
    assert_equal 8, sales_analyst.total_items
  end

  def test_it_can_return_total_number_of_merchants
    assert_equal 6, sales_analyst.total_merchants
  end

  def test_it_can_return_average_items_per_merchant
    assert_equal 1.33, sales_analyst.average_items_per_merchant
  end

  def test_it_can_return_array_with_the_number_of_items_for_each_merchant
    assert_equal [1,1,1,1,2,2], sales_analyst.collect_items_per_merchant.sort
  end

  def test_it_can_return_array_of_items_given_merchant_id
    assert_instance_of Array, sales_analyst.items_given_merchant_id(101)
    assert_instance_of Array, sales_analyst.items_given_merchant_id(102)
    assert_equal 2, sales_analyst.items_given_merchant_id(101).length
    assert_equal 2, sales_analyst.items_given_merchant_id(102).length
  end

  def test_it_can_determine_average_price_per_merchant
    assert_equal 7.50, sales_analyst.average_item_price_for_merchant(101)
    assert_equal 15.00, sales_analyst.average_item_price_for_merchant(102)
  end

  def test_it_can_find_the_average_average_price_of_all_merchants
    assert_equal 24.58, sales_analyst.average_average_price_per_merchant
  end

  def test_it_can_retrieve_all_item_proces
    assert_equal [5,10,10,10,15,20,40,60], sales_analyst.get_all_prices.sort
  end

  def test_it_can_find_golden_prices
    assert_equal 1, sales_analyst.golden_prices.length
  end

  def test_it_can_return_a_golden_item
    assert_equal 1, sales_analyst.golden_items.length
  end

  def test_golden_items_returns_an_array
    assert Array, sales_analyst.golden_items.class
  end

  def test_it_can_calculate_number_of_items_for_every_merchant
    assert_equal [1,1,1,1,2,2], sales_analyst.number_of_items_for_every_merchant.sort
  end

  def test_it_can_calculate_merchants_with_high_item_count
    assert_equal 2, sales_analyst.merchants_with_high_item_count.length
  end


end
