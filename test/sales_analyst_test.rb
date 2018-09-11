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

    assert_equal 1.67, sales_analyst.average_item_per_merchant
  end

  def test_it_has_average_items_per_merchants_standard_deviation
    se = SalesEngine.from_csv({
    :items     => "./short_tests/short_items.csv",
    :merchants => "./short_tests/short_merchants.csv",
    })

    sales_analyst = SalesAnalyst.new(se)

    assert_equal 3.26, sales_analyst.average_items_per_merchants_standard_deviation
  end
end
