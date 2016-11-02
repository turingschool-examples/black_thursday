require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  attr_reader :sales_analyst

  def setup
    sales_engine = SalesEngine.from_csv({
      :items => "./data_fixtures/items_fixture.csv",
      :merchants => "./data_fixtures/merchants_fixture.csv"
    })
    @sales_analyst = SalesAnalyst.new(sales_engine)
  end
  
  def test_sales_analyst_exists
    assert sales_analyst
  end

  def test_calculates_average_items_per_merchant
    assert_equal 0.65, sales_analyst.average_items_per_merchant
  end

  def test_calculates_average_items_per_merchant_standard_deviation
    assert_equal 2.23, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count_returns_merchants_above_one_st_dev_in_item_count
    top_merchants = sales_analyst.merchants_with_high_item_count
    assert top_merchants.all? {|merchant| merchant.items.length > 3.26}
  end

  def test_average_item_price_for_merchant_returns_average_as_big_decimal
    average_price = sales_analyst.average_item_price_for_merchant(12334195)
    assert_equal BigDecimal(419.8,4), average_price.round(2)
  end

  def test_average_item_price_for_merchant_returns_0_if_merchant_has_no_items
    average_price = sales_analyst.average_item_price_for_merchant(12334145)
    assert_equal BigDecimal(0), average_price.round(2)
  end

  def test_average_item_price_for_merchant_returns_price_if_merchant_has_one_item
    average_price = sales_analyst.average_item_price_for_merchant(12334141)
    assert_equal BigDecimal(12,4), average_price.round(2)
  end

  def test_average_average_price_per_merchant_returns_average
    average_average_price = sales_analyst.average_average_price_per_merchant
    assert_equal BigDecimal(27.09, 4), average_average_price.round(2)
  end

  def test_golden_items_returns_items_two_standard_devs_above_average_item_price
    golden_items = sales_analyst.golden_items
    assert golden_items.all? {|item| item.unit_price > 250}
  end

end