require './test/test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      :items     => "./data/items.csv",
      :customers => "./data/customers.csv",
      :invoices  => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv"
      })

    @sa = SalesAnalyst.new(@se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_has_sales_engine
    assert_instance_of SalesEngine, @sa.engine
  end

  def test_merchant_returns_correct_count
    assert_equal 475, @sa.merchant_count
  end

  def test_item_test_returns_correct_count
    assert_equal 1367, @sa.item_count
  end

  def test_merchent_items_count_returns_correct_item_count_for_given_merchant
    assert_equal 1, @sa.merchant_items_count(12334112)
  end

  def test_it_returns_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_it_can_find_average_items_per_merchant_std_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_returns_array_of_high_item_count_merchants
    assert_instance_of Array, @sa.merchants_with_high_item_count
  end

  def test_merchant_items_returns_array_with_items_of_given_merchant
    items_of_merchant = @sa.merchant_items(12334149)

    assert_instance_of Array, items_of_merchant
    assert_equal Item, items_of_merchant.first.class
    assert_equal 1, items_of_merchant.count
  end

  def test_returns_bigdecimal_for_average_item_price_given_merchant_id
    assert_instance_of BigDecimal, @sa.average_item_price_for_merchant(12334159)
  end

  def test_average_average_price_per_merchant_returns_bigdecimal
    assert_instance_of BigDecimal, @sa.average_average_price_per_merchant
  end

  def tests_average_item_price_returns_correct_float
    assert_instance_of BigDecimal, @sa.average_item_price
  end

  def test_golden_items_returns_array
    assert_instance_of Array, @sa.golden_items
  end
end
