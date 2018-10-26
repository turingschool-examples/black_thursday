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
    assert_equal 1366.00, @sa.count_all_items - 1
  end

  def test_it_can_count_all_merchants
    assert_equal 475.00, @sa.count_all_merchants
  end

  def test_merchant_item_count
    assert_equal 475, @sa.all_merchant_item_count.count
  end

  def test_merchant_count_minus_average
    assert_equal 475, @sa.merchant_count_minus_average.count
  end
  
  # def test_it_can_calculate_standard_deviation
  #   assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  # end
end
