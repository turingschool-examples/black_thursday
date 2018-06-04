require './test/test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv',
      customers: './data/customers.csv'
    })
    @sa = se.analyst
  end

  def test_sales_analyst_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_sales_analyst_finds_average_items_per_merchant
    expected = @sa.average_items_per_merchant

    assert_equal 2.88, expected
    assert_equal Float, expected.class
  end

  def test_sales_analyst_finds_standard_deviation_of_items_per_merchant
    expected = @sa.average_items_per_merchant_standard_deviation

    assert_equal 3.26, expected
    assert_equal Float, expected.class
  end

  def test_sales_analyst_finds_which_merchants_have_high_item_counts
    expected = @sa.merchants_with_high_item_count

    assert_equal 52, expected.count
    assert_equal Merchant, expected.first.class
  end

  def test_sales_analyst_finds_average_item_price_per_merchant
    merchant_id = 12334105
    expected = @sa.average_item_price_for_merchant(merchant_id)

    assert_equal 16.66, expected
    assert_equal BigDecimal, expected.class
  end

  def test_sales_analyst_finds_average_average_price_per_merchant
    expected = @sa.average_average_price_per_merchant

    assert_equal 350.29, expected
    assert_equal BigDecimal, expected.class
  end

  def test_sales_analyst_finds_golden_items
    expected = @sa.golden_items

    assert_equal 5, expected.length
    assert_equal Item, expected.first.class
  end

  def test_sales_analyst_calculates_average_invoices_per_merchant
    expected = @sa.average_invoices_per_merchant

    assert_equal 4985, expected.count
    assert_equal true, expected.all? do |invoice|
      instance.class == Invoice
    end
  end
end
