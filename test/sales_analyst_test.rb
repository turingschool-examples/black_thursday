require './test_helper'
require './lib/merchant'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/file_loader'
require './lib/sales_engine'
require 'pry'

class SalesAnalystTest < MiniTest::Test
  include FileLoader
  def setup
    @sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })

    @sales_analyst = @sales_engine.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_can_get_average_items_per_merchant
    assert_equal 2.88, @sales_analyst.average_items_per_merchant
  end

  def test_it_can_get_average_items_per_merchant_standard_deviation
    skip
    assert_equal 3.26, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_can_get_single_merchants_total_items
    assert_equal 20, @sales_analyst.single_merchants_total_items(12334195)
  end
end
