require_relative './helper'
require_relative '../lib/sales_engine'
class SalesAnalystTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv( {
        :items      => './data/items.csv',
        :merchants  => './data/merchants.csv'
                                } )
    @sa = se.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_can_return_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_it_can_count_total_number_of_items
    assert_equal 1367.00, @sa.count_all_items
  end

  def test_it_can_count_all_merchants
    assert_equal 475.00, @sa.count_all_merchants
  end

  def test_it_can_calculate_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_return_merchants_with_high_count
    assert_equal 52, @sa.merchants_with_high_item_count.count
  end

  def test_it_can_return_average_item_price_for_a_merchant
    assert_equal 16.66, @sa.average_item_price_for_merchant(12334105)
  end

  def test_it_can_return_average_price_for_all_merchants
    assert_equal 350.29, @sa.average_average_price_per_merchant
  end

  def test_can_record_standard_deviation_for_item_price
    assert_equal 2899.93, @sa.price_standard_deviation
  end

  def test_it_can_return_golden_items
      assert_equal 5, @sa.golden_items.length
  end
end
