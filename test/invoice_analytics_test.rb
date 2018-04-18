require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/analytics/invoice_analytics'

# Invoice Analytics test
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

  def test_getting_invoice_count
    sales_analyst = new_sales_analyst_invoices_2
    assert_equal 2, sales_analyst.invoice_count(12334264)
  end

  def test_can_count_by_invoice_created_date
    exp_time = Time.parse('2009-02-07')
    actual = @sales_analyst.invoice_count_by_created_date(exp_time)
    assert_equal 1, actual
  end

  def test_average_number_of_invoices_per_day
    sales_analyst = new_sales_analyst_b
    assert_equal 1, sales_analyst.average_invoices_per_day
  end

  def test_average_invoices_per_day_standard_deviation
    sales_analyst = new_sales_analyst_b
    result = sales_analyst.average_invoices_per_day_standard_deviation
    assert_equal 0, result
  end

  def test_average_invoices_per_weekday
    sales_analyst = new_sales_analyst_c
    assert_equal 3.17, sales_analyst.average_invoices_per_weekday.to_f
  end

  def test_average_invoices_per_weekday_standard_deviation
    sales_analyst = new_sales_analyst_c
    actual = sales_analyst.average_invoices_per_weekday_standard_deviation
    assert_equal 2.14, actual
  end

  def test_average_invoices_per_weekday_plus_one_standard_deviation
    sales_analyst = new_sales_analyst_c
    axl = sales_analyst.average_invoices_per_weekday_plus_one_standard_deviation
    assert_equal 5.31, axl.to_f
  end

  def test_number_of_invoices_by_weekday
    sales_analyst = new_sales_analyst_c
    result = sales_analyst.number_of_invoices_by_weekday
    assert_equal 6, result.length
    expected = %w[saturday friday wednesday monday sunday thursday]
    assert_equal expected, result.keys
    assert_equal [4, 6, 2, 5, 1, 1], result.values
  end

  def test_top_days_by_invoice_count
    sales_analyst = new_sales_analyst_c
    assert_equal %w[Friday], sales_analyst.top_days_by_invoice_count
  end

  def test_number_of_invoices_by_status
    sales_analyst = new_sales_analyst_c
    result = sales_analyst.number_of_invoices_by_status(:returned)
    assert_equal 2, result.length
  end

  def test_total_of_invoice_paid_in_full
    sales_analyst = new_sales_analyst_inv_paid
    assert_equal 5570.75, sales_analyst.invoice_total(1)
  end

  def test_it_finds_best_invoice_by_revenue
    sales_analyst = new_sales_analyst_5
    result = sales_analyst.best_invoice_by_revenue
    assert_equal 18, result.id
    assert_instance_of Invoice, result
  end

  def test_invoices_by_quantity
    sales_analyst = new_sales_analyst_5
    result = sales_analyst.invoices_by_quantity
    assert_equal 47, result.keys.max
  end

  def test_it_finds_best_invoice_by_quantity
    sales_analyst = new_sales_analyst_5
    result = sales_analyst.best_invoice_by_quantity
    assert_equal 1, result.id
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

  def new_sales_analyst_inv_paid
    sales_engine = SalesEngine.from_csv(
      customers: './test/fixtures/test_customers.csv',
      invoices: './test/fixtures/test_invoices_transactions.csv',
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
