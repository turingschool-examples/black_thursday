require_relative 'test_helper'
# require_relative 'sales_engine'
# require_relative 'sales_analyst'

class SalesAnalystTest < Minitest::Test
  def setup
    item_path = "./data/items.csv"
    merchant_path = "./data/merchants.csv"
    arguments = {
                  :items     => item_path,
                  :merchants => merchant_path,
                }
    se = SalesEngine.from_csv(arguments)
    @sales_analyst = se.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_has_parent
    assert_instance_of SalesEngine, @sales_analyst.parent
  end

  def test_it_can_return_average_items_per_merchant
    assert_equal 2.88, @sales_analyst.average_items_per_merchant
  end

  def test_all_items_count_helper
    assert_equal 1367, @sales_analyst.all_items_count
  end

  def test_all_merchants_count_helper
    assert_equal 475, @sales_analyst.all_merchants_count
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 3.26, @sales_analyst.average_items_per_merchant_standard_deviation
  end


end