require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

# Test for the SalesAnalyst class
class SalesAnalystTest < Minitest::Test
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

  def test_sales_analyst_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_average
    assert_equal 2, @sales_analyst.average(4, 2)
  end

  def test_standard_deviation
    set = [3, 4, 5]
    avg = @sales_analyst.average(set.reduce(:+), set.count)
    assert_equal 1, @sales_analyst.standard_deviation(set, avg)
  end

  def test_number_of_merchants
    assert_equal 5, @sales_analyst.number_of(:merchants)
  end

  def test_number_of_items
    assert_equal 14, @sales_analyst.number_of(:items)
  end

  def test_items_per_merchant
    result = @sales_analyst.items_per_merchant
    assert(result.all? { |_id, items| items.class == Array })
    assert_instance_of Item, result.values[0][0]
    assert_instance_of Item, result.values[-1][-1]
  end

  def test_number_of_items_per_merchant
    expected = { 12334185 => 3, 12334213 => 2, 12334195 => 7,
                 12334315 => 1, 12334499 => 1 }
    assert_equal expected, @sales_analyst.number_of_items_per_merchant
  end

  def test_number_of_invoices_per_merchant
    sales_analyst = new_sales_analyst_b
    expected = { 12335938 => 1, 12334753 => 1, 12334269 => 1,
                 12335311 => 1, 12334389 => 1, 12335009 => 1,
                 12337139 => 1, 12336965 => 1, 12334839 => 1,
                 12335955 => 2, 12334264 => 2, 12334873 => 5 }
    assert_equal expected, sales_analyst.number_of_invoices_per_merchant
  end

  def test_merchants_per_count
    sales_analyst = new_sales_analyst_b
    expected = { 1 => [12335938, 12334753, 12334269,
                       12335311, 12334389, 12335009,
                       12337139, 12336965, 12334839],
                 2 => [12335955, 12334264],
                 5 => [12334873] }
    assert_equal expected, sales_analyst.merchants_per_count
  end

  def test_average_invoices_per_merchant
    sales_analyst = new_sales_analyst_invoices_2
    assert_equal 1.15, sales_analyst.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    sales_analyst = new_sales_analyst_invoices_2
    actual = sales_analyst.average_invoices_per_merchant_standard_deviation
    assert_equal 0.63, actual
  end

  def test_average_invoices_per_merchant_plus_two_standard_deviations
    analyst = new_sales_analyst_b
    actual = analyst.average_invoices_per_merchant_plus_two_standard_deviations
    assert_equal 3.72, actual
  end

  def test_average_invoices_per_merchant_minus_two_standard_deviations
    analyst = new_sales_analyst_c
    actual = analyst.average_invoices_per_merchant_minus_two_standard_deviations
    assert_equal (-1.44), actual
  end

  def test_percentage_of_invoices_pending
    sales_analyst = new_sales_analyst_c
    assert_equal 52.63, sales_analyst.invoice_status(:pending)
  end

  def test_percentage_of_invoices_shipped
    sales_analyst = new_sales_analyst_c
    assert_equal 36.84, sales_analyst.invoice_status(:shipped)
  end

  def test_percentage_of_invoices_returned
    sales_analyst = new_sales_analyst_c
    assert_equal 10.53, sales_analyst.invoice_status(:returned)
  end

  def test_invoice_paid_in_full
    sales_analyst = new_sales_analyst_inv_paid
    assert sales_analyst.invoice_paid_in_full?(750)
    refute sales_analyst.invoice_paid_in_full?(751)
  end

  def test_invoice_totals_by_customer
    sales_analyst = new_sales_analyst_5
    result = sales_analyst.invoice_totals_by_customer
    assert_instance_of Hash, result
  end

  def test_it_finds_total_invoice_items
    sales_analyst = new_sales_analyst_5
    result = sales_analyst.total_invoice_items(1)
    assert_equal 47, result
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
end
