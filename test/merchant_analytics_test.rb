require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/analytics/merchant_analytics.rb'

# Merchant Analytics test
class MerchantAnalyticsTest < Minitest::Test
  def setup
    sales_engine = SalesEngine.from_csv(
      customers: './test/fixtures/test_customers.csv',
      invoices: './test/fixtures/test_invoices.csv',
      invoice_items: './test/fixtures/test_invoice_items.csv',
      items: './test/fixtures/test_items1.csv',
      merchants: './test/fixtures/test_merchants1.csv',
      transactions: './test/fixtures/test_transactions.csv'
    )
    @sales_analyst = SalesAnalyst.new(sales_engine)
  end

  def test_average_items_per_merchant
    assert_equal 2.80, @sales_analyst.average_items_per_merchant
    assert_instance_of Float, @sales_analyst.average_items_per_merchant
  end

  def test_average_items_per_merchant_std_dev
    result = @sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal 2.49, result
    assert_instance_of Float, result
  end

  def test_merchants_with_high_item_count
    result = @sales_analyst.merchants_with_high_item_count
    assert_instance_of Merchant, result[0]
    assert_equal ['FlavienCouche'], result.map(&:name)
  end

  def test_average_item_price_for_merchant
    result = @sales_analyst.average_item_price_for_merchant(12334185)
    assert_instance_of BigDecimal, result
    assert_equal 11.17, result.to_f.round(2)
  end

  def test_average_average_price_per_merchant
    result = @sales_analyst.average_average_price_per_merchant
    assert_instance_of BigDecimal, result
    assert_equal 20092.68, result.to_f.round(2)
  end

  def test_top_merchants_by_invoice_count
    sales_analyst = new_sales_analyst_b
    result = sales_analyst.top_merchants_by_invoice_count
    assert_instance_of Merchant, result[0]
    assert_equal [12334873], result.map(&:id)
  end

  def test_bottom_merchants_by_invoice_count
    sales_analyst = new_sales_analyst_c
    result = sales_analyst.bottom_merchants_by_invoice_count
    assert(result.all? { |each_result| each_result.class == Merchant })
    assert_equal [], result.map(&:id)
  end

  def new_sales_analyst_b
    sales_engine = SalesEngine.from_csv(
      customers: './test/fixtures/test_customers.csv',
      invoices: './test/fixtures/test_invoices2_b.csv',
      invoice_items: './test/fixtures/test_invoice_items.csv',
      items: './test/fixtures/test_items1.csv',
      merchants: './test/fixtures/test_merchants2.csv',
      transactions: './test/fixtures/test_transactions.csv'
    )
    sales_engine.analyst
  end

  def new_sales_analyst_c
    sales_engine = SalesEngine.from_csv(
      customers: './test/fixtures/test_customers.csv',
      invoices: './test/fixtures/test_invoices2_c.csv',
      invoice_items: './test/fixtures/test_invoice_items.csv',
      items: './test/fixtures/test_items1.csv',
      merchants: './test/fixtures/test_merchants2.csv',
      transactions: './test/fixtures/test_transactions.csv'
    )
    sales_engine.analyst
  end
end
