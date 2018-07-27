require './test/test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'
require 'pry'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      })
    @sa = SalesAnalyst.new(@se)
  end

  def test_it_exists
    # skip
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_can_create_an_instance_of_sales_engine
    # skip
    assert_instance_of SalesEngine, @sa.se
  end

  def test_it_can_group_items_by_merchant
    result = @sa.group_items_by_merchant
    assert_equal 475, result.length
    assert_equal 6, result[12334185].length
  end

  def test_items_per_merchant
    result = @sa.items_per_merchant
    assert_equal 475, result.length
    assert_equal 1, result[0]
  end

  def test_count_items_per_merchant
    assert_equal 6, @sa.items_per_merchant[1]
  end

  def test_it_can_find_the_average_number_of_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal 114, @sa.merchants_with_high_item_count.length
    assert_instance_of Merchant, @sa.merchants_with_high_item_count[0]
    assert_instance_of Merchant, @sa.merchants_with_high_item_count[-1]
  end

  def test_select_merchant_ids_over_standard_deviation
    assert_equal 114, @sa.select_merchant_ids_over_standard_deviation.length
    assert_instance_of Fixnum, @sa.select_merchant_ids_over_standard_deviation[-1]
    assert_instance_of Fixnum, @sa.select_merchant_ids_over_standard_deviation[0]
  end

  def test_average_item_price_for_merchant
    assert_equal 10.78, @sa.average_item_price_for_merchant(12334185)
    assert_instance_of BigDecimal, @sa.average_item_price_for_merchant(12334185)
  end

  def test_average_average_price_per_merchant
    assert_instance_of BigDecimal, @sa.average_average_price_per_merchant
    assert_equal 350.29, @sa.average_average_price_per_merchant
  end

end
