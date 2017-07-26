require './lib/sales_engine'
require './lib/sales_analyst'
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'

class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
          :items     => "./test/data/items_fixture.csv",
          :merchants => "./test/data/merchants_fixture.csv",
          })

    @sa = SalesAnalyst.new(@se)
  end

  def test_class_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_average_items_per_merchant
    assert_equal 0.82, @sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 1.75, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_instance_of Array, @sa.merchants_with_high_item_count
    assert_equal 2, @sa.merchants_with_high_item_count.count
  end

  def test_average_item_price_for_merchant
    assert_instance_of BigDecimal, @sa.average_item_price_for_merchant(12334105)
    assert_equal 29.99, @sa.average_item_price_for_merchant(12334105).to_f.round(2)
  end

  def test_average_average_price_per_merchant
    assert_instance_of BigDecimal, @sa.average_average_price_per_merchant
    assert_equal 75.82, @sa.average_average_price_per_merchant.to_f.round(2)
  end

  def test_golden_items
    assert_instance_of Array, @sa.golden_items
    assert_instance_of Item, @sa.golden_items[0]
  end
end
