require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def test_sales_analyst_can_be_instantiated_with_sales_engine
    se = SalesEngine.from_csv({
      :items     => "../data/items.csv",
      :merchants => "../data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)
    assert sa
  end

  def test_can_calculate_average_items_per_merchant
    se = SalesEngine.from_csv({
      :items     => "../data/items.csv",
      :merchants => "../data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_can_calculate_average_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv({
      :items     => "../data/items.csv",
      :merchants => "../data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_can_calculate_number_for_one_std_dev
    se = SalesEngine.from_csv({
      :items     => "../data/items.csv",
      :merchants => "../data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)
    assert_equal 6.14, sa.one_std_dev
  end

  def test_can_calculate_number_for_two_std_dev
    se = SalesEngine.from_csv({
      :items     => "../data/items.csv",
      :merchants => "../data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)
    assert_equal 9.40, sa.two_std_dev
  end

  def test_can_calculate_merchants_more_than_one_std_dev_from_avg_number_of_products_offered
    se = SalesEngine.from_csv({
      :items     => "../data/items.csv",
      :merchants => "../data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)
    assert_equal 52, sa.merchants_with_high_item_count.count
  end

  def test_can_calculate_average_item_price_for_specific_merchant_id_for_merchants_with_high_item_count
    se = SalesEngine.from_csv({
      :items     => "../data/items.csv",
      :merchants => "../data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)
    assert_equal BigDecimal, sa.average_item_price_for_merchant("12334105").class
    assert_equal 10.00, sa.average_item_price_for_merchant("12334105").to_f.round(2)
  end

  def test_can_calculate_sum_of_all_the_averages_to_find_average_price_across_all_merchants
    se = SalesEngine.from_csv({
      :items     => "../data/items.csv",
      :merchants => "../data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal BigDecimal, sa.average_average_price_per_merchant.class
    assert_equal 151.65, sa.average_average_price_per_merchant.to_f.round(2)
  end
end
