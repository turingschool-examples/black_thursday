require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'pry'

class SalesAnalystTest < Minitest::Test

  def setup
    sales_engine = SalesEngine.from_csv({
      :items => './test/fixtures/items_fixture.csv',
      :merchants => './test/fixtures/merchants.csv',
      :invoices => './test/fixtures/invoices.csv',
      :invoice_items => './test/fixtures/invoice_items.csv',
      :transactions => './test/fixtures/transactions.csv',
      :customers => './test/fixtures/customers.csv'})
    @sales_analyst = SalesAnalyst.new(sales_engine)
  end

  def test_that_we_find_average_items_per_merchant
    assert_equal 1.5, @sales_analyst.average_items_per_merchant
  end

  def test_it_can_find_standard_deviation
    assert_equal 0.71, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_can_find_merchants_with_high_item_count
    m_1 = @sales_analyst.sales_engine.merchants.merchants[0]

    assert_equal [m_1], @sales_analyst.merchants_with_high_item_count
  end

  def test_it_can_determine_average_price_for_merchant_with_id
    assert_equal 48.33, @sales_analyst.average_item_price_for_merchant(12334112)
  end

  def test_it_can_determine_average_price_per_merchant
    assert_equal 201.83, @sales_analyst.average_average_price_per_merchant
  end

  def test_it_can_find_golden_items
    item_1 = @sales_analyst.sales_engine.items.all[8]

    assert_equal [item_1], @sales_analyst.golden_items
  end

  def test_it_can_find_average_invoices_per_merchant
    assert_equal 4.9, @sales_analyst.average_invoices_per_merchant
  end

  def test_it_can_find_average_items_per_merchant_standard_deviation
    assert_equal 1.45, @sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_it_can_find_top_merchants_by_invoice_count
    m_1 = @sales_analyst.sales_engine.merchants.merchants[0]

    assert_equal [m_1], @sales_analyst.top_merchants_by_invoice_count
  end

  def test_it_can_find_bottom_merchants_by_invoice_count
    m_1 = @sales_analyst.sales_engine.merchants.merchants[4]

    assert_equal [m_1], @sales_analyst.bottom_merchants_by_invoice_count
  end

  def test_it_detects_which_day_of_the_week_has_most_sales
    assert_equal ["Friday", "Saturday"], @sales_analyst.top_days_by_invoice_count
  end

  def test_percentage_of_instances_of_statuses
    assert_equal 51.02, @sales_analyst.invoice_status(:pending)
    assert_equal 32.65, @sales_analyst.invoice_status(:shipped)
    assert_equal 16.33, @sales_analyst.invoice_status(:returned)
  end

  def test_it_calculates_total_revenue_by_date
    date = Time.parse("2009-02-07")
    assert_equal 21067.77, @sales_analyst.total_revenue_by_date(date)
  end

  def test_it_determines_top_revenue_earners
    m_1 = @sales_analyst.sales_engine.merchants.merchants[0]
    m_2 = @sales_analyst.sales_engine.merchants.merchants[3]
    m_3 = @sales_analyst.sales_engine.merchants.merchants[6]

    assert_equal [m_1, m_2], @sales_analyst.top_revenue_earners(2)
    # assert_equal [merchant_1, merchant_2, merchant_3], @sales_analyst.top_revenue_earners(3)
  end

  def test_we_find_merchants_that_sell_only_one_item

    m_1 = @sales_analyst.sales_engine.merchants.merchants[1]
    m_2 = @sales_analyst.sales_engine.merchants.merchants[3]
    m_3 = @sales_analyst.sales_engine.merchants.merchants[5]
    m_4 = @sales_analyst.sales_engine.merchants.merchants[6]
    m_5 = @sales_analyst.sales_engine.merchants.merchants[7]
    m_6 = @sales_analyst.sales_engine.merchants.merchants[8]
    m_7 = @sales_analyst.sales_engine.merchants.merchants[9]

    assert_equal [m_1, m_2, m_3, m_4, m_5, m_6, m_7],
                @sales_analyst.merchants_with_only_one_item
  end

  def test_merchants_can_be_singled_out_by_one_item_per_month
    m_1 = @sales_analyst.sales_engine.merchants.merchants[7]

    assert_equal [m_1],
    @sales_analyst.merchants_with_only_one_item_registered_in_month("March")
  end
end
