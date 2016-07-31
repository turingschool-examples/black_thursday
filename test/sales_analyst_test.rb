gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'bigdecimal'


class SalesAnalystTest < MiniTest::Test
  def setup
    @sa = SalesAnalyst.new(SalesEngine.new({
                                             :items     => "./data/items.csv",
                                             :merchants => "./data/merchants.csv",
                                            }))
  end

  def test_it_has_copy_of_sales_engine
    assert_instance_of SalesEngine, @sa.sales_engine
  end

  def test_it_can_find_how_many_items_a_merchant_has
    assert_equal 1, @sa.merchant_items_count(12334141)
  end

  def test_it_knows_the_number_of_merchants
    assert_equal 475, @sa.merchant_count
  end

  def test_item_count
    assert_equal 9, @sa.item_count
  end

  def test_average_items_per_merchant
    assert_equal 0.02, @sa.average_items_per_merchant
  end

  def test_it_can_access_all_the_merchants
    assert_instance_of Merchant, @sa.all_merchants.last
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 0.2, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal 5, @sa.merchants_with_high_item_count.count
  end
end
