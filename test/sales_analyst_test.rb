require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require 'minitest/autorun'
require 'minitest/emoji'
require 'bigdecimal'
require 'pry'

class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
              :items => "./test/data/items_fixture.csv",
              :merchants => "./test/data/merchants_fixture.csv",
              :invoice_items => "./test/data/invoice_items_fixture.csv",
              :invoices => "./test/data/invoices_fixture.csv",
              :transactions => "./test/data/transactions_fixture.csv",
              :customers => "./test/data/customers_fixture.csv"
            })
    @sa = SalesAnalyst.new(@se)
  end

  def test_class_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_average_items_per_merchant
    assert_equal 0.82, @sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 1.76, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_instance_of Array, @sa.merchants_with_high_item_count
    assert_equal 2, @sa.merchants_with_high_item_count.count
  end

  def test_average_item_price_for_merchant
    assert_instance_of BigDecimal, @sa.average_item_price_for_merchant(12334105)
    assert_equal 29.99, @sa.average_item_price_for_merchant(12334105).to_f.round(2)
  end

  def test_average_average_price_per_merchant
    assert_instance_of BigDecimal, @sa.average_average_price_per_merchant
    assert_equal 75.82, @sa.average_average_price_per_merchant.to_f.round(2)
  end

  def test_golden_items
    assert_instance_of Array, @sa.golden_items
    assert_instance_of Item, @sa.golden_items[0]
  end

  def test_average_invoices_per_merchant
    assert_equal 10.0, @sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 0.9, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    assert_instance_of Array, @sa.top_merchants_by_invoice_count
    assert_instance_of Merchant, @sa.top_merchants_by_invoice_count[0]
  end

  def test_bottom_merchants_by_invoice_count
    assert_instance_of Array, @sa.top_merchants_by_invoice_count
    assert_equal 2, @sa.top_merchants_by_invoice_count[0]
  end

  def test_turn_date_to_day
    assert_equal "Thursday", @sa.turn_date_to_day("2017-07-27")
  end

  def test_top_days_by_invoice_count
    assert_instance_of Array, @sa.top_days_by_invoice_count
    assert_equal "Sunday", @sa.top_days_by_invoice_count[0]
  end

end
