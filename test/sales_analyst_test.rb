require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
      :items      => './data/items.csv',
      :merchants  => './data/merchants.csv'
      })
    @sa = se.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_can_return_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_it_can_return_items_per_merchant_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_return_merchants_with_high_item_count
    top_sellers = @sa.merchants_with_high_item_count
    assert_instance_of Array, top_sellers
    m1 = top_sellers[0]
    assert_instance_of Merchant, m1
    m1_items = @sa.engine.items.find_all_by_merchant_id(m1.id)
    assert m1_items.count > (2.88 + (3.26 * 2))
    assert_instance_of Merchant, top_sellers[5]
    assert_instance_of Merchant, top_sellers[-1]
    refute top_sellers.include?(@sa.engine.merchants.find_by_id(12335009))
  end

  def test_average_item_price_for_merchant
    average = @sa.average_item_price_for_merchant(12334105)
    assert_instance_of BigDecimal, average
    assert_equal 16.66, average
  end

  def test_average_average_price_per_merchant
    average = @sa.average_average_price_per_merchant
    assert_instance_of BigDecimal, average
    assert_equal 350.29, average
  end

  def test_average_item_cost
    assert_equal 251.06, @sa.average_item_cost
  end

  def test_unit_price_standard_deviation
    assert_equal 2900.99, @sa.item_unit_price_standard_deviation
  end

  def test_golden_items
    golden = @sa.golden_items
    assert_instance_of Array, golden
    assert_instance_of Item, golden[0]
    assert_instance_of Item, golden[-1]
    assert golden.include?(@sa.engine.items.find_by_id(263554072))
    refute golden.include?(@sa.engine.items.find_by_id(263529916))
  end
end
