require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/analytics/customer_analytics'

# Customer Analytics test
class CustomerAnalyticsTest < Minitest::Test
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

  def test_it_grabs_top_buyers
    sales_analyst = new_sales_analyst_5
    result = sales_analyst.top_buyers(3)
    assert_equal 1, result.first.id
    assert_equal 3, result.last.id
    assert_instance_of Customer, result.first
  end

  def test_it_finds_top_merchant_for_customer
    sales_analyst = new_sales_analyst_5
    result = sales_analyst.top_merchant_for_customer(1)
    assert_instance_of Merchant, result
    assert_equal 12335955, result.id
  end

  def test_it_finds_one_time_buyers
    sales_analyst = new_sales_analyst_5
    result = sales_analyst.one_time_buyers
    assert_equal 3, result.length
    assert_instance_of Customer, result.first
    assert_equal [4, 19, 20], result.map(&:id)
  end

  def test_it_finds_one_time_buyers_invoice_items
    sales_analyst = new_sales_analyst_5
    result = sales_analyst.one_time_buyers_invoice_items
    assert_equal 8, result.length
    assert_instance_of InvoiceItem, result.first
  end

  def test_it_finds_one_time_buyers_top_item
    utilities = one_time_buyers_analyst
    sales_analyst = utilities[0]
    the_item = utilities[1].items.items[263505548]
    assert_equal the_item, sales_analyst.one_time_buyers_top_item
  end

  def test_customers_with_unpaid_invoices
    sales_analyst = new_sales_analyst_5
    result = sales_analyst.customers_with_unpaid_invoices
    assert_instance_of Customer, result.first
    assert_equal 25, result.length
  end

  def one_time_buyers_analyst
    sales_engine = SalesEngine.from_csv(
      customers: './data/customers.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      items: './data/items.csv',
      merchants: './test/fixtures/test_merchants2.csv',
      transactions: './test/fixtures/test_transactions5.csv'
    )
    [sales_engine.analyst, sales_engine]
  end

  def new_sales_analyst_5
    sales_engine = SalesEngine.from_csv(
      customers: './test/fixtures/test_customers5.csv',
      invoices: './test/fixtures/test_invoices5.csv',
      invoice_items: './test/fixtures/test_invoice_items5.csv',
      items: './test/fixtures/test_items5.csv',
      merchants: './test/fixtures/test_merchants2.csv',
      transactions: './test/fixtures/test_transactions5.csv'
    )
    sales_engine.analyst
  end
end
