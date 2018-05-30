require_relative 'test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.new({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        })
    @sa = @se.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_returns_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
    assert_equal Float, @sa.average_items_per_merchant.class
  end

  def test_it_returns_the_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
    assert_equal Float, @sa.average_items_per_merchant_standard_deviation.class
  end

  def test_returns_merchants_more_than_one_standard_deviation_above_the_average_number_of_products_offered
     assert_equal 52, @sa.merchants_with_high_item_count.length
     assert_equal Merchant, @sa.merchants_with_high_item_count.first.class
  end

  def test_returns_the_average_item_price_for_the_given_merchant
      average_item_price = @sa.average_item_price_for_merchant(12334105)

      assert_equal 16.66, average_item_price
      assert_equal BigDecimal, average_item_price.class
  end
end
