require_relative './test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })

    @sa = SalesAnalyst.new(@se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_can_create_instance_of_sales_engine
    assert_instance_of SalesEngine, @se
  end

  def test_it_can_group_items_by_merchant_id
    assert_equal 1, @sa.group_items_by_merchant[12334141].count
    assert_equal 6, @sa.group_items_by_merchant[12334185].count
  end

  def test_it_can_find_number_of_merchants
    grouped_items = {
                    12334141 => ["item_1", "item_2"],
                    12334185 => ["item_1", "item_2", "item_3"]
    }
    assert_equal 2, @sa.find_number_of_merchants(grouped_items)
  end

  def test_it_can_find_number_items
    grouped_items = {
                    12334141 => ["item_1", "item_2"],
                    12334185 => ["item_1", "item_2", "item_3"]
    }
    assert_equal 5, @sa.find_total_number_of_items(grouped_items)
  end

  def test_it_can_find_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
    assert_equal Float, @sa.average_items_per_merchant.class
  end

  def test_it_can_find_average_items_per_merchant_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
    assert_equal Float, @sa.average_items_per_merchant_standard_deviation.class
  end

  def test_it_can_find_number_of_items_for_each_merchant
    grouped_items = {
                    12334141 => ["item_1", "item_2"],
                    12334185 => ["item_1", "item_2", "item_3"],
                    12345678 => ["item_1", "item_2", "item_3", "item_4"]
                  }
    assert_equal [2, 3, 4], @sa.items_per_merchant(grouped_items)
  end

  def test_it_can_find_variance
    item_count_array = [2, 3, 4, 3, 5]
    average = 3.4
    assert_equal 5.2, @sa.variance(average, item_count_array)
  end

  def test_it_can_find_square_root_of_variance
    v = 5.2
    ipm = [2, 3, 4, 3, 5]
    assert_equal 1.14, @sa.square_root_of_variance(v, ipm)
  end
end
