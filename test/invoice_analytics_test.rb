require_relative '../test/test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/invoice_analytics'

class InvoiceAnalyticsTest < Minitest::Test
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

  def test_average_invoices_per_merchant
    sales_analyst = new_sales_analyst_invoices_2
    assert_equal 1.15, sales_analyst.average_invoices_per_merchant
  end

  def test_average_invoices_per_day_standard_deviation
    sales_analyst = new_sales_analyst_b
    result = sales_analyst.average_invoices_per_day_standard_deviation
    assert_equal 0, result
  end

  def test_average_invoices_per_merchant_standard_deviation
    sales_analyst = new_sales_analyst_invoices_2
    assert_equal 0.63, sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_average_number_of_invoices_per_day
    sales_analyst = new_sales_analyst_b
    assert_equal 1, sales_analyst.average_invoices_per_day
  end

  def test_top_days_by_invoice_count
    sales_analyst = new_sales_analyst_c
    assert_equal %w[Friday], sales_analyst.top_days_by_invoice_count
  end

  def test_it_finds_best_invoice_by_revenue
    sales_analyst = new_sales_analyst_5
    result = sales_analyst.best_invoice_by_revenue
    assert_equal 15, result.id
    assert_instance_of Invoice, result
  end

  def test_it_finds_best_invoice_by_quantity
    sales_analyst = new_sales_analyst_5
    result = sales_analyst.best_invoice_by_quantity
    assert_equal 3, result.id
    assert_instance_of Invoice, result
  end

  def new_sales_analyst_invoices_2
    sales_engine = SalesEngine.from_csv(
      customers: './test/fixtures/test_customers.csv',
      invoices: './test/fixtures/test_invoices2.csv',
      invoice_items: './test/fixtures/test_invoice_items.csv',
      items: './test/fixtures/test_items1.csv',
      merchants: './test/fixtures/test_merchants2.csv',
      transactions: './test/fixtures/test_transactions.csv'
    )
    sales_engine.analyst
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
