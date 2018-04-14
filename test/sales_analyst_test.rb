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

  def test_average_items_per_merchant
    assert_equal 2.80, @sales_analyst.average_items_per_merchant
    assert_instance_of Float, @sales_analyst.average_items_per_merchant
  end

  def test_average_items_per_merchant_std_dev
    result = @sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal 2.49, result
    assert_instance_of Float, result
  end

  def test_items_per_merchant
    result = @sales_analyst.items_per_merchant
    assert(result.all? { |_id, items| items.class == Array })
    assert_instance_of Item, result.values[0][0]
    assert_instance_of Item, result.values[-1][-1]
  end

  def test_number_of_items_per_merchant
    expected = { 12334185 => 3,
                 12334213 => 2,
                 12334195 => 7,
                 12334315 => 1,
                 12334499 => 1 }
    assert_equal expected, @sales_analyst.number_of_items_per_merchant
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

  def test_average_item_price
    assert_equal 7357.66, @sales_analyst.average_item_price.to_f.round(2)
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

  def test_average_invoices_per_merchant
    sales_analyst = new_sales_analyst_invoices_2
    assert_equal 1.15, sales_analyst.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    sales_analyst = new_sales_analyst_invoices_2
    assert_equal 0.63, sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_getting_invoice_count
    sales_analyst = new_sales_analyst_invoices_2
    assert_equal 2, sales_analyst.invoice_count(12334264)
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

  def test_average_number_of_invoices_per_day
    sales_analyst = new_sales_analyst_b
    assert_equal 1, sales_analyst.average_invoices_per_day
  end

  def test_average_invoices_per_day_standard_deviation
    sales_analyst = new_sales_analyst_b
    result = sales_analyst.average_invoices_per_day_standard_deviation
    assert_equal 0, result
  end

  def test_number_of_invoices_per_merchant
    sales_analyst = new_sales_analyst_b
    expected = {
      12335938 => 1,
      12334753 => 1,
      12334269 => 1,
      12335311 => 1,
      12334389 => 1,
      12335009 => 1,
      12337139 => 1,
      12336965 => 1,
      12334839 => 1,
      12335955 => 2,
      12334264 => 2,
      12334873 => 5
    }
    assert_equal expected, sales_analyst.number_of_invoices_per_merchant
  end

  def test_merchants_per_count
    sales_analyst = new_sales_analyst_b
    expected = {
      1 => [12335938,
            12334753,
            12334269,
            12335311,
            12334389,
            12335009,
            12337139,
            12336965,
            12334839],
      2 => [12335955, 12334264],
      5 => [12334873]
    }
    assert_equal expected, sales_analyst.merchants_per_count
  end

  def test_average_invoices_per_merchant_plus_two_standard_deviations
    sales_analyst = new_sales_analyst_b
    assert_equal 3.72, sales_analyst.average_invoices_per_merchant_plus_two_standard_deviations
  end

  def test_average_invoices_per_merchant_minus_two_standard_deviations
    sales_analyst = new_sales_analyst_c
    assert_equal -1.44, sales_analyst.average_invoices_per_merchant_minus_two_standard_deviations
  end

  def test_number_of_invoices_by_weekday
    sales_analyst = new_sales_analyst_c
    result = sales_analyst.number_of_invoices_by_weekday
    assert_equal 6, result.length
    assert_equal %w[saturday friday wednesday monday sunday thursday], result.keys
    assert_equal [4, 6, 2, 5, 1, 1], result.values
  end

  def test_average_invoices_per_weekday
    sales_analyst = new_sales_analyst_c
    assert_equal 3.17, sales_analyst.average_invoices_per_weekday.to_f
  end

  def test_average_invoices_per_weekday_standard_deviation
    sales_analyst = new_sales_analyst_c
    assert_equal 2.14, sales_analyst.average_invoices_per_weekday_standard_deviation
  end

  def test_average_invoices_per_weekday_plus_one_standard_deviation
    sales_analyst = new_sales_analyst_c
    assert_equal 5.31, sales_analyst.average_invoices_per_weekday_plus_one_standard_deviation.to_f
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

  def test_invoice_paid_in_full
    sales_engine = SalesEngine.from_csv(
      customers: './test/fixtures/test_customers.csv',
      invoices: './test/fixtures/test_invoices_transactions.csv',
      invoice_items: './test/fixtures/test_invoice_items.csv',
      items: './test/fixtures/test_items1.csv',
      merchants: './test/fixtures/test_merchants2.csv',
      transactions: './test/fixtures/test_transactions.csv'
    )
    sales_analyst = sales_engine.analyst

    assert sales_analyst.invoice_paid_in_full?(750)
    refute sales_analyst.invoice_paid_in_full?(751)
  end

  def test_total_of_invoice_paid_in_full
    sales_engine = SalesEngine.from_csv(
      customers: './test/fixtures/test_customers.csv',
      invoices: './test/fixtures/test_invoices_transactions.csv',
      invoice_items: './test/fixtures/test_invoice_items.csv',
      items: './test/fixtures/test_items1.csv',
      merchants: './test/fixtures/test_merchants2.csv',
      transactions: './test/fixtures/test_transactions.csv'
    )
    sales_analyst = sales_engine.analyst
    assert_equal 5570.75, sales_analyst.invoice_total(1)
  end

  def test_it_grabs_top_buyers
    sales_engine = SalesEngine.from_csv(
      customers: './test/fixtures/test_customers5.csv',
      invoices: './test/fixtures/test_invoices_transactions.csv',
      invoice_items: './test/fixtures/test_invoice_items.csv',
      items: './test/fixtures/test_items1.csv',
      merchants: './test/fixtures/test_merchants2.csv',
      transactions: './test/fixtures/test_transactions.csv'
    )
    sales_analyst = sales_engine.analyst
    assert_equal [], sales_analyst.top_buyers(5)
  end
end
