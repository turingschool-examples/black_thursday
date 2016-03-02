require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require '../lib/merchant'
require '../lib/merchant_repository'
require '../lib/item'
require '../lib/item_repository'
require '../lib/sales_engine'
require '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def test_sales_analyst_can_be_instantiated_with_sales_engine
    se = SalesEngine.from_csv({
      :items     => "../data/items.csv",
      :merchants => "../data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)

    assert sa
  end

  def test_sales_analyst_can_calculate_average_items_per_merchant
    se = SalesEngine.from_csv({
      :items     => "../data/items.csv",
      :merchants => "../data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_sales_analyst_can_calculate_average_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv({
      :items     => "../data/items.csv",
      :merchants => "../data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end
end
