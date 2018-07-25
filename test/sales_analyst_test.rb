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
    assert_equal 475, @sa.find_number_of_merchants
  end

  def test_it_can_find_number_items
    assert_equal 1367, @sa.find_number_of_items
  end

  def test_it_can_find_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end
end
