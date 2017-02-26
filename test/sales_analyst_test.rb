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

  def test_it_returns_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_it_can_find_average_items_per_merchant_std_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_returns_array_of_high_item_count_merchants
    assert_instance_of Array, @sa.merchants_with_high_item_count
  end

  def test_returns_bigdecimal_for_average_item_price_give_merchant_id
    assert_instance_of BigDecimal, @sa.average_item_price_for_merchant(12334159)
  end

  def test_average_average_price_per_merchant_returns_bigdecimal
    assert_instance_of BigDecimal, @sa.average_average_price_per_merchant
  end
end
