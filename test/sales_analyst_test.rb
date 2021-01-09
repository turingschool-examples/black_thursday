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

  def test_it_can_return_average_items_per_merchant_standard_deviation
    assert_equal 3.26, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_can_return_merchants_with_high_items_count
    assert_equal 52, @sales_analyst.merchants_with_high_item_count.length
    assert_instance_of Merchant, @sales_analyst.merchants_with_high_item_count.last
  end

  def test_average_item_price_for_merchant
    assert_equal 16.66, @sales_analyst.average_item_price_for_merchant(12334105)
  end

  def test_it_can_return_total_items
    assert_equal 1367, @sales_analyst.total_items
  end

  def test_it_can_return_total_merchants
    assert_equal 475, @sales_analyst.total_merchants
  end

  def test_merchant_items_count
    assert_equal 475, @sales_analyst.merchant_item_count.length
  end

end
