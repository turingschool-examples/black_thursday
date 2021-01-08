# require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/analyst'
require 'CSV'

class AnalystTest < Minitest::Test

  def setup
    data = {
            :items     => "./dummy_data/dummy_items.csv",
            :merchants => "./dummy_data/dummy_merchants.csv"
            #Add CSV dummy files
            }
    sales_engine = SalesEngine.new(data)
    @sales_analyst = sales_engine.analyst
  end

  def test_it_exists
    assert_instance_of Analyst, @sales_analyst
  end

  def test_average_items_per_merchant
    assert_equal 4, @sales_analyst.total_merchants
    assert_equal 5, @sales_analyst.total_items_across_all_merchants
    assert_equal ["1", "2", "3", "4"], @sales_analyst.items_per_merchant.keys
    assert_equal 1.25, @sales_analyst.average_items_per_merchant
  end

  def test_it_can_calculate_standard_deviation
    assert_equal [1, 2, 1, 1], @sales_analyst.all_items_by_merchant
  end


end
