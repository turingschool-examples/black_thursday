require 'simplecov'
SimpleCov.start
require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def test_it_exists
    merchant_repository = []
    item_repository = []
    sa = SalesAnalyst.new(merchant_repository, item_repository)

    assert_instance_of SalesAnalyst, sa
  end

  def test_we_can_initialize_by_sales_engine
    se = SalesEngine.new
    sa = se.analyst
    assert_instance_of SalesAnalyst, sa
  end

  def test_we_can_get_the_average_items_per_merchant
    se = SalesEngine.from_csv({merchants: './data/merchants.csv', items: './data/items.csv'})
    sa = se.analyst
    expected = 2.88
    result = sa.average_items_per_merchant

    assert_equal expected, result
  end

  def test_we_can_get_the_standard_deviation
    se = SalesEngine.from_csv({merchants: './data/merchants.csv', items: './data/items.csv'})
    sa = se.analyst
    expected = 3.26
    result = sa.average_items_per_merchant_standard_deviation
    assert_equal expected, result
  end

end
