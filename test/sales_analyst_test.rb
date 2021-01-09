require_relative './test_helper'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })

    @sales_analyst = SalesAnalyst.new(@se)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_average_items_per_merchant
    assert_equal 2.88, @sales_analyst.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 3.26, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal 52, @sales_analyst.merchant_names_with_high_item_count.count
    assert_equal Merchant, @sales_analyst.merchants_with_high_item_count[0].class
  end

  def test_average_item_price_for_merchant
    assert_equal 16.66, @sales_analyst.average_item_price_for_merchant(12334105)
  end

  def test_average_average_price_per_merchant
    assert_equal 350.29, @sales_analyst.average_average_price_per_merchant
  end

  def test_golden_items
    assert_equal 1367, @sales_analyst.unit_price_array.count
    assert_equal Array, @sales_analyst.golden_items.class
    assert_equal Item, @sales_analyst.golden_items[1].class
    assert_equal 5, @sales_analyst.golden_items.count
  end
end
