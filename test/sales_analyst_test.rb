require './lib/sales_engine'
require './lib/sales_analyst'
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'

class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          })

    @sa = SalesAnalyst.new(@se)
  end

  def test_class_exists
    skip
    assert_instance_of SalesAnalyst, @sa
  end

  def test_average_items_per_merchant
    skip
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    skip
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    skip
    assert_instance_of Array, @sa.merchants_with_high_item_count
    assert_equal 52, @sa.merchants_with_high_item_count.count
  end

  def test_average_item_price_for_merchant
    skip
    assert_instance_of BigDecimal, @sa.average_item_price_for_merchant(12334159)
    assert_equal 31.50, @sa.average_item_price_for_merchant(12334159).to_f.round(2)
  end

  def test_average_average_price_per_merchant
    skip
    assert_instance_of BigDecimal, @sa.average_average_price_per_merchant
    assert_equal 350.29, @sa.average_average_price_per_merchant.to_f.round(2)
  end

  def test_golden_items
    assert_instance_of Array, @sa.golden_items
    assert_instance_of Item, @sa.golden_items[0]
  end
end
