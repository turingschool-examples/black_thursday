require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv"})
    @sa = SalesAnalyst.new(se)
  end

  def test_it_created_an_instance_of_sales_analyst_class
    assert_equal SalesAnalyst, @sa.class
  end

  def test_it_can_find_the_average
    average = @sa.average_items_per_merchant
    assert average
    assert_equal 2.88, average
  end

  def test_it_can_find_average_item_price_for_merchant
    average = @sa.average_item_price_for_merchant(12337411)
    assert average
    assert_equal 30.00, average
  end

  def test_it_can_find_average_average_price_per_merchant
    average = @sa.average_average_price_per_merchant
    assert average
    assert_equal 350.29, average
  end

  def test_it_can_return_standard_deviation
    std_dev = @sa.average_items_per_merchant_standard_deviation
    assert_equal 3.26, std_dev
  end

  def test_it_can_find_merchants_with_high_item_count
    merchants = @sa.merchants_with_high_item_count
    assert_equal Array, merchants.class
    assert_equal Merchant, merchants[0].class
  end

  def test_it_can_find_golden_items
    items = @sa.golden_items
    assert_equal Array, items.class
    assert_equal Item, items[0].class
  end


end
