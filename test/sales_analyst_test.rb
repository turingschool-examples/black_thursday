require_relative 'test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv'
    })
    @sales_analyst = @sales_engine.analyst
    @merchant_repository = @sales_engine.merchants
    @item_repository = @sales_engine.items
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_average_items_per_merchant
    assert_equal 2.88, @sales_analyst.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    actual = @sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal 3.26, actual
  end

  def test_group_items_by_merchant_id
    expected = @merchant_repository.all.count
    actual = @sales_analyst.items_by_merchant_id.keys.count
    assert_equal expected, actual

    assert @sales_analyst.items_by_merchant_id.values[0].all? do |item|
      @sales_analyst.items_by_merchant_id.keys[0] == @sales_analyst.items_by_merchant_id.values[0].merchant_id
    end
  end

  def test_merchants_with_high_item_count
    actual = @sales_analyst.merchants_with_high_item_count[0]
    assert_instance_of Merchant, actual
    assert_equal 52, @sales_analyst.merchants_with_high_item_count.count
  end

  def test_find_all_items_for_a_merchant_id
    merchant_id = 12334783
    actual = @sales_analyst.average_item_price_for_merchant(merchant_id)
    assert_equal BigDecimal(47.5, 3), actual
  end

  def test_find_all_items_for_a_merchant_id
    merchant_id = 12334783
    actual = @sales_analyst.average_item_price_for_merchant(merchant_id)
    assert_equal BigDecimal(47.5, 3), actual
  end

  def test_it_can_return_all_item_unit_prices
    assert_instance_of Array, @sales_analyst.all_item_unit_prices
    assert_equal 1367, @sales_analyst.all_item_unit_prices.count
  end

  def test_it_can_find_the_average_unit_price
    assert_equal 251.06, @sales_analyst.average_item_unit_price.to_f
  end

  def test_it_can_calculate_the_item_unit_price_variance
    assert_equal 1367, @sales_analyst.price_variance.count
  end

  def test_it_can_sum_all_price_variances
    assert_equal 2900.99, @sales_analyst.unit_price_std_dev
  end

end
