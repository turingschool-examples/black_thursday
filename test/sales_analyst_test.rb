require_relative './test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  def test_it_exist
    se = SalesEngine.from_csv({
    :items     => "./short_tests/short_items.csv",
    :merchants => "./short_tests/short_merchants.csv",
    })

    sales_analyst = SalesAnalyst.new(se)
    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_it_has_average_item_per_merchants
    se = SalesEngine.from_csv({
    :items     => "./short_tests/short_items.csv",
    :merchants => "./short_tests/short_merchants.csv",
    })

    sales_analyst = SalesAnalyst.new(se)

    assert_equal 2.33, sales_analyst.average_item_per_merchant
  end

  def test_it_has_average_items_per_merchants_standard_deviation
    se = SalesEngine.from_csv({
    :items     => "./short_tests/short_items.csv",
    :merchants => "./short_tests/short_merchants.csv",
    })

    sales_analyst = SalesAnalyst.new(se)

    assert_equal 1.53, sales_analyst.average_items_per_merchants_standard_deviation
  end

  def test_it_can_count_merchants_with_a_high_count
    se = SalesEngine.from_csv({
    :items     => "./short_tests/short_items.csv",
    :merchants => "./short_tests/short_merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(se)
    merchant_1 = se.merchants.find_all_by_name("Candisart")

    assert_equal merchant_1,sales_analyst.merchants_with_high_item_count
  end

  def test_it_can_calculate_average_item_price_for_merchant
    se = SalesEngine.from_csv({
    :items     => "./short_tests/short_items.csv",
    :merchants => "./short_tests/short_merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(se)
    merchant_1 = se.merchants.find_all_by_name("Candisart")

    assert_instance_of BigDecimal, sales_analyst.average_item_price_for_merchant(3)
    assert_equal 12.25, sales_analyst.average_item_price_for_merchant(3).to_f
  end
end
