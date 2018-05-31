require_relative 'test_helper.rb'
require_relative '../lib/sales_engine.rb'
require_relative '../lib/sales_analyst'
require 'csv'
class SalesAnalystTest < Minitest::Test
  def setup
    @engine = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      customers: './data/customers.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv'
    })
    @sales_analyst = @engine.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_average_items_per_merchant_returns_average_items_per_merchant
    expected = @sales_analyst.average_items_per_merchant

    assert_equal 2.88, expected
    assert_instance_of Float, expected
  end

  def test_average_items_per_merchant_standard_deviation_returns_the_standard_deviation
    expected = @sales_analyst.average_items_per_merchant_standard_deviation

    assert_equal 3.26, expected
    assert_instance_of Float, expected
  end

  def test_merchants_with_high_item_count_returns_correct_merchants
    expected = @sales_analyst.merchants_with_high_item_count

    assert_equal 52, expected.length
    assert_instance_of Merchant, expected.first
  end

  def test_average_item_price_for_merchant_returns_average_item_price_for_merchant
    merchant_id = 12334105
    expected = @sales_analyst.average_item_price_for_merchant(merchant_id)

    assert_equal 16.66, expected
    assert_instance_of BigDecimal, expected
  end

  def test_average_average_price_per_merchant_returns_average_item_price
    expected = @sales_analyst.average_average_price_per_merchant

    assert_equal 350.29, expected
    assert_instance_of BigDecimal, expected
  end

  def test_golden_items_returns_correct_items
    expected = @sales_analyst.golden_items

    assert_equal 5, expected.length
    assert_instance_of Item, expected.first
  end

  def test_average_invoices_per_merchant_returns_average_number_of_invoices
    expected = @sales_analyst.average_invoices_per_merchant

    assert_equal 10.49, expected
    assert_instance_of Float, expected
  end

  def test_average_invoices_per_merchant_standard_deviation_finds_std_deviation
    expected = @sales_analyst.average_invoices_per_merchant_standard_deviation

    assert_equal 3.29, expected
    assert_instance_of Float, expected
  end

  def test_top_merchants_by_invoice_count_returns_correct_merchants
    expected = @sales_analyst.top_merchants_by_invoice_count

    assert_equal 12, expected.length
    assert_instance_of Merchant, expected.first
  end

  def test_bottom_merchants_by_invoice_count_returns_correct_merchants
    expected = @sales_analyst.bottom_merchants_by_invoice_count

    assert_equal 4, expected.length
    assert_instance_of Merchant, expected.first
  end

  def test_top_days_by_invoice_count_returns_correct_dats
    expected = @sales_analyst.top_days_by_invoice_count

    assert_equal ['Wednesday'], expected
  end

  def test_invoice_status_reuturns_correct_percentage_of_given_status
    expected = @sales_analyst.invoice_status(:pending)
    assert_equal 29.55, expected

    expected = @sales_analyst.invoice_status(:shipped)
    assert_equal 56.95, expected

    expected = @sales_analyst.invoice_status(:returned)
    assert_equal 13.50, expected
  end

end
