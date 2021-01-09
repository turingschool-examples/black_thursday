require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  def setup
    merchant_path = './data/merchants.csv'
    item_path = './data/items.csv'
    locations = { items: item_path,
                  merchants: merchant_path }

    sales_engine = SalesEngine.from_csv(locations)
    @sales_analyst = sales_engine.analyst
  end

  def test_it_exists_and_has_attributes
    assert_instance_of SalesAnalyst, @sales_analyst
    assert_instance_of SalesEngine, @sales_analyst.sales_engine
  end

  def test_it_can_return_average_items_per_merchant
    assert_equal 2.88, @sales_analyst.average_items_per_merchant
  end

  def test_it_can_return_total_items
    assert_equal 1367, @sales_analyst.total_items
  end

  def test_it_can_return_total_merchants
    assert_equal 475, @sales_analyst.total_merchants
  end

end
