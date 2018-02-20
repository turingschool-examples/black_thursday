require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(
      items:     './test/fixtures/items_list_truncated.csv',
      merchants: './test/fixtures/merchants_list_truncated.csv'
    )
    @sales_analyst = SalesAnalyst.new(@se)
  end

  def test_it_exists_and_sales_engine_argument
    assert_instance_of SalesAnalyst, @sales_analyst
    assert_equal @se, @sales_analyst.sales_engine
  end

  def test_for_items_per_merchant
    expected = [1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3]
    actual = @sales_analyst.items_per_merchant
    assert_equal expected, actual
  end

  def test_for_average_items_per_merchant
    assert_equal 0.30, @sales_analyst.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    actual = @sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal 0.73, actual
  end

  def test_merchants_with_high_item_count
    actual = @sales_analyst.merchants_with_high_item_count

    assert actual.is_a?(Array)
    assert actual[0].is_a?(Merchant)
    assert_equal 1, actual.count
    assert_equal 'Madewithgitterxx', actual[0].name
  end

  def test_for_average_item_price_for_merchant
    actual = @sales_analyst.average_item_price_for_merchant(12_334_185)

    assert actual.is_a?(BigDecimal)
    assert_equal 0.111_667e4, actual
  end

  def test_for_average_average_price_per_merchant
    actual = @sales_analyst.average_average_price_per_merchant

    assert actual.is_a?(BigDecimal)
    assert_equal 0.340_784e3, actual
  end

  def test_for_item_unit_prices
    expected = [0.12e4, 0.13e4, 0.135e4, 0.7e3, 0.15e4, 0.2999e4,
                0.149e5, 0.149e4, 0.69e3, 0.4e5, 0.13e5, 0.399e3,
                0.8e4, 0.6e5, 0.65e5, 0.4e4, 0.239e4, 0.5e5, 0.239e4,
                0.5e5]
    actual = @sales_analyst.item_unit_prices

    assert_equal expected, actual
  end

  def test_for_average_item_price
    actual = @sales_analyst.average_item_price

    assert_equal 16_065.40, actual
  end

  def test_for_item_price_standard_deviation
    actual = @sales_analyst.item_price_standard_deviation

    assert_equal 22_670.45, actual
  end

  def test_for_golden_items
    actual = @sales_analyst.golden_items

    assert actual.is_a?(Array)
    assert actual[0].is_a?(Item)
    assert_equal 'La prière', actual[0].name
  end
end
