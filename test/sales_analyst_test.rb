require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'

require './lib/sales_analyst'
require './lib/sales_engine'

# Sales Analyst test class
class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv(
      merchants: './data/merchants.csv',
      items: './data/items.csv'
    )
    @sa = @se.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_has_sales_engine
    assert_instance_of SalesEngine, @sa.engine
  end

  def test_it_calculates_average_items_per_merchant
    skip

  end

  def test_it_calculates_average_items_per_merchant_standard_devation
    skip
  end

  def test_it_calculates_merchants_with_high_item_count
    skip
  end

  def test_it_calculates_average_item_price_for_merchant
    skip
    #takes argument of merchant id
  end

  def test_it_calculates_average_price_per_merchant
    skip
  end

  def test_it_identifies_golden_items
    skip
  end
end
