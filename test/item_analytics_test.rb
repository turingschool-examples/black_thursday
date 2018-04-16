require_relative '../test/test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/analytics/item_analytics'

class ItemAnalyticsTest < Minitest::Test
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

  def test_average_item_price_standard_deviation
    result = @sales_analyst.average_item_price_standard_deviation
    assert_equal 26665.15, result
    assert_instance_of Float, result
  end

  def test_golden_items
    result = @sales_analyst.golden_items
    assert_equal ['Test listing'], result.map(&:name)
    assert_instance_of Item, result[0]
  end

  def test_items_bought_in_year
    skip
    sales_engine = SalesEngine.from_csv(
      customers: './test/fixtures/test_customers.csv',
      invoices: './test/fixtures/test_invoices.csv',
      invoice_items: './test/fixtures/test_invoice_items.csv',
      items: './test/fixtures/test_items1.csv',
      merchants: './test/fixtures/test_merchants1.csv',
      transactions: './test/fixtures/test_transactions.csv'
    )
    sales_analyst = SalesAnalyst.new(sales_engine)
    result = sales_analyst.items_bought_in_year(1, 2009)
    assert_instance_of Item, result[0]
    assert_instance_of Item, result[1]
    assert_equal [263519844, 263451719], result.map(&:id)
  end
end
