require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class ItemAnalystTest < Minitest::Test

  attr_reader :sales_analyst

  def setup
    sales_engine = SalesEngine.from_csv({
      :items => "./test/data_fixtures/items_fixture.csv",
      :merchants => "./test/data_fixtures/merchants_fixture.csv"
    })
    @sales_analyst = SalesAnalyst.new(sales_engine)
  end

  def test_golden_items_returns_items_two_standard_devs_above_average_item_price
    golden_items = sales_analyst.golden_items
    assert golden_items.all? {|item| item.unit_price > 250}
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

end
  