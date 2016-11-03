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
    assert sales_analyst.sales_engine
  end

  def test_it_can_return_total_number_of_items
    skip
    assert_equal 16, sales_analyst.total_items
  end

  def test_it_can_return_total_number_of_merchants
    skip
    assert_equal 8, sales_analyst.total_merchants
  end

  def test_it_can_return_average_items_per_merchant
    skip
    assert_equal 2, sales_analyst.average_items_per_merchant
  end

end