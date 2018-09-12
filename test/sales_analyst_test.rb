require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  def test_it_exists
    new_salesanalyst = SalesAnalyst.new('ir', 'mr')

    assert_instance_of SalesAnalyst, new_salesanalyst
  end

  def test_that_sales_analyst_initializes_with_ir_and_mr
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    sales_analyst = se.analyst

    assert_instance_of MerchantRepository, sales_analyst.mr
    assert_instance_of ItemRepository, sales_analyst.ir
  end

  def test_it_calculates_average_items_per_merchant
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    sales_analyst = se.analyst

    assert_equal 2.88, sales_analyst.average_items_per_merchant

  end

  def test_it_calculates_standard_deviation
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    sales_analyst = se.analyst

    assert_equal 3.26, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_returns_merchants_more_than_one_standard_deviation
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    sales_analyst = se.analyst

    assert_equal 52, sales_analyst.merchants_with_high_item_count.count
  end

  def test_sales_analyst_calculates_merchant_average_item_price
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    sales_analyst = se.analyst

    actual = sales_analyst.average_item_price_for_merchant(12334105)
    assert_instance_of BigDecimal, actual
    assert_equal 16.66, (actual.to_f).round(2)
  end

  def test_that_sales_analyst_average_average_price_per_merchant
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    sales_analyst = se.analyst

    actual = sales_analyst.average_average_price_per_merchant
    assert_instance_of BigDecimal, actual
    assert_equal 350.29, (actual.to_f).round(2)
  end

  def test_that_golden_items_returns_most_expensive_items
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    sales_analyst = se.analyst

    actual = (sales_analyst.golden_items).count
    assert_equal 5, actual
    assert_instance_of Item, sales_analyst.golden_items[0]
  end
end
