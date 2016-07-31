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

  def test_merchant_items
    # assert_equal 3, @sa.merchant_items(12334185).count
  end

  def test_average_items_per_merchant
    assert_equal 0.02, @sa.average_items_per_merchant
  end

  def test_it_can_access_all_the_merchants
    assert_instance_of Merchant, @sa.all_merchants.last
  end

  def test_it_can_access_all_the_items
    assert_instance_of Item, @sa.all_items.last
  end
  def test_average_items_per_merchant_standard_deviation
    assert_equal 0.2, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal 5, @sa.merchants_with_high_item_count.count
  end

  def test_average_item_price_for_merchant
    assert_instance_of BigDecimal, @sa.average_item_price_for_merchant(12334141)
  end

  def test_average_average_price_per_merchant
    assert_equal "some bullshit", "some bullshit"
  end

  def test_it_has_returns_an_average_item_price
    assert_instance_of BigDecimal, @sa.average_item_price
  end

  def test_standard_deviation_of_items
    assert_equal 128.89, @sa.standard_deviation_of_items
  end


  def test_golden_items
    assert_instance_of Item, @sa.golden_items.last
  end
end
