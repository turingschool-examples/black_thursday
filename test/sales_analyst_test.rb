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
    skip
    assert_equal 2.88, @sales_analyst.average_items_per_merchant
  end
end