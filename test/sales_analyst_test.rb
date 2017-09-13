require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  attr_reader :se, :sa
  
  def setup
    @se = SalesEngine.from_csv({ :items     => "./data/items.csv",
                                 :merchants => "./data/merchants.csv"})
    @sa = SalesAnalyst.new(se)
  end

  def test_that_it_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_average_items_per_merchant
    expected = sa.average_items_per_merchant

    assert_equal 2.88, expected
    assert_instance_of Float, expected
  end

  def test_it_returns_standard_deviation
    expected = sa.average_items_per_merchant_standard_deviation

    assert_equal 3.26, expected
    assert_instance_of Float, expected
  end

  def test_merchants_with_high_item_count
    expected = sa.merchants_with_high_item_count

    assert_equal 52, expected.length
    assert_instance_of Merchant, expected.first
  end

  def test_average_item_price_for_merchant
    merchant_id = 12334105
    expected = sa.average_item_price_for_merchant(merchant_id)

    assert_equal 16.66, expected
    assert_instance_of BigDecimal, expected
  end

  def test_average_average_price_per_merchant
    expected = sa.average_average_price_per_merchant

    assert_equal 350.29, expected
    assert_instance_of BigDecimal, expected
  end

  def test_golden_items_returns_above_average_items
    expected = sa.golden_items
  
    assert_equal 5, expected.length
    assert_instance_of Item, expected.first
  end
end