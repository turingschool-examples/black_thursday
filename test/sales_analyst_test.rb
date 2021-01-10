require_relative './test_helper'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./fixture_data/items_fixtures_file.csv",
      :merchants => "./fixture_data/merchants.csv",
      })
  end

  def test_it_exists_and_has_attributes
    assert_instance_of SalesAnalyst, @se.analyst
  end

  def test_average_items_per_merchant
    assert_equal 2.88, @se.analyst.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 0.58, @se.analyst.average_item_standard_deviation
  end
  
  def test_merchants_with_high_item_count
    assert_equal 52, @se.analyst.merchant_names_with_high_item_count.count
    assert_equal Merchant, @se.analyst.merchants_with_high_item_count[0].class
  end

  def test_average_item_price_for_merchant
    assert_equal 16.66, @se.analyst.average_item_price_for_merchant(12334105)
  end

  def test_average_average_price_per_merchant
    assert_equal 350.29, @se.analyst.average_average_price_per_merchant
  end

  def test_golden_items
    assert_equal 29, @se.analyst.unit_price_array.count
    assert_equal Array, @se.analyst.golden_items.class
    assert_equal Item, @se.analyst.golden_items[1].class
    assert_equal 7, @se.analyst.golden_items.count
  end
end
