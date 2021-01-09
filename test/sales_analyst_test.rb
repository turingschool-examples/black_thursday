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

  def test_average_items_per_merchant_standard_devitation
    assert_equal 3.26, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  # def test_merchants_with_high_item_count
  #   @sales_analyst.merchants_with_high_item_count
  # end

  def test_average_item_price_for_merchant
    assert_equal 16.66, @sales_analyst.average_item_price_for_merchant(12334105)
  end

  # def test_average_average_price_per_merchant
  #   assert_equal [], @sales_analyst.average_average_price_per_merchant
  # end
  #
  # def golden_items
  #   assert_equal [], @sales_analyst.golden_items
  # end
end
