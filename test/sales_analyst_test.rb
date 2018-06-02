require_relative 'test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv'
    })
    @sales_analyst = @sales_engine.analyst
    @merchant_repository = @sales_engine.merchants
    @item_repository = @sales_engine.items
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_average_items_per_merchant
    assert_equal 2.88, @sales_analyst.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    actual = @sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal 3.26, actual
  end

  def test_merchants_with_high_item_count
    assert @sales_analyst.merchants_with_high_item_count.all? do |element|
      Merchant == element.class
    end
    assert_equal 52, @sales_analyst.merchants_with_high_item_count.count
  end

  def test_calculates_average_item_price_for_merchant
    actual = @sales_analyst.average_item_price_for_merchant(12334783)
    assert_equal BigDecimal(47.5, 3), actual
  end

  def test_calculate_average_average_item_price_for_merchant
    actual = @sales_analyst.average_average_price_per_merchant
    assert_equal 350.29, actual
  end

  # def test_items_can_be_grouped_by_merchant_id
  #   expected = @merchant_repository.all.count
  #   actual = @sales_analyst.items_grouped_by_merchant_id.keys.count
  #   assert_equal expected, actual
  #
  #   assert @sales_analyst.items_grouped_by_merchant_id.values[0].all? do |item|
  #     @sales_analyst.items_grouped_by_merchant_id.keys[0] == @sales_analyst.items_grouped_by_merchant_id.values[0].merchant_id
  #   end
  # end

  # def test_item_count_for_each_merchant_id
  #   skip
  #   # assert_equal [], @sales_analyst.item_count_for_each_merchant_id
  # end

  # def test_it_can_return_all_item_unit_prices
  #   skip
  #   assert_instance_of Array, @sales_analyst.all_item_unit_prices
  #   assert_equal 1367, @sales_analyst.all_item_unit_prices.count
  # end

  # def test_it_can_find_the_average_unit_price
  #   assert_equal 251.06, @sales_analyst.average_item_unit_price.to_f
  # end

  # def test_it_can_calculate_the_item_unit_price_variance
  #   skip
  #   assert_equal 1367, @sales_analyst.price_variance.count
  # end

  # def test_it_can_sum_all_price_variances
  #   skip
  #   assert_equal 2900.99, @sales_analyst.unit_price_std_dev
  # end

  def test_it_can_find_all_golden_items
    assert_equal 5, @sales_analyst.golden_items.count
  end

  # def test_it_can_find_average_invoices_per_merchant
  #   skip
  #   assert_equal 10.49, @sales_analyst.average_invoices_per_merchant
  # end

end
