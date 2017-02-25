require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'


class SalesAnalystTest < Minitest::Test

  attr_reader :file_hash, :se, :sa

  def setup
    @file_hash = {

      items: './data/items.csv',
      merchants: './data/merchants.csv'
    }
    @se = SalesEngine.new(file_hash)
    @sa = SalesAnalyst.new(se)
  end

 def test_it_exists
   assert_equal SalesAnalyst, sa.class
 end

 def test_it_can_average_items_per_merchant
   assert_equal 2.88, sa.average_items_per_merchant
 end

 def test_average_items_per_merchant_standard_deviation
   assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
 end

 def test_it_can_find_merchants_with_high_item_count
   assert_equal Array, sa.merchants_with_high_item_count.class
 end

 def test_it_can_find_average_price_for_merchant
   assert_equal BigDecimal, sa.average_item_price_for_merchant(12334159).class
 end

 def test_average_average_price_per_merchant
   assert_equal BigDecimal, sa.average_average_price_per_merchant.class
 end

 def test_it_can_find_average_price_deviation
  assert_equal Float, sa.average_price_standard_deviation.class
 end

 def test_it_can_find_golden_items

   assert_equal Array, sa.golden_items.class
 end

 def test_it_can_find_number_of_golden_items
   assert_equal 5, sa.golden_items.count
 end
end
