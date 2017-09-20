require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < MiniTest::Test
  attr_reader :se, :sa

  def setup
    @se = SalesEngine.new({merchants:"./data/merchants.csv",
    items:"./data/items.csv",
    invoices:"./data/invoices.csv",
    invoice_items:"./data/invoice_items.csv",
    transactions:"./data/transactions.csv",
    customers:"./data/customers.csv"})
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesEngine, se
    assert_instance_of SalesAnalyst, sa
  end

  def test_average_items_per_merchant
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal 52, sa.merchants_with_high_item_count.count
  end

  def test_average_item_price_for_merchant
    assert_equal 0.1666e2, sa.average_item_price_for_merchant(12334105)
  end

  def test_average_average_price_for_merchant
    assert_equal 350.29, sa.average_average_price_per_merchant
  end

  def test_standard_deviation_for_golden_items
    assert_equal 291154.08, sa.find_standard_deviation_of_average_item_price
  end

  def test_golden_items
    assert_equal 5, sa.golden_items.count
  end

  def test_average_invoices_per_merchant
    assert_equal 10.49, sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 3.29, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    assert_equal 12, sa.top_merchants_by_invoice_count.count
  end

  def test_bottom_merchants_by_invoice_count
    assert_equal 4, sa.bottom_merchants_by_invoice_count.count
  end

  def test_top_days_by_invoice_count
    assert_equal ["Wednesday"], sa.top_days_by_invoice_count
  end

  def test_invoice_status
    assert_equal 29.55, sa.invoice_status(:pending)
    assert_equal 56.95, sa.invoice_status(:shipped)
    assert_equal 13.5, sa.invoice_status(:returned)
  end

  def test_total_revenue_by_date
    date = Time.parse("2009-02-07")

    assert_equal 21067.77, sa.total_revenue_by_date(date)
  end

  def test_top_revenue_by_earners
    assert_equal 20, sa.top_revenue_earners(20).count
  end

  def test_ranked_by_revenue
    assert_equal 12334634, sa.merchants_ranked_by_revenue.first.id
    assert_equal 12336175, sa.merchants_ranked_by_revenue.last.id
  end
  
  def test_best_item_for_merchant
    assert_equal 263516130, sa.best_item_for_merchant(12334189).id
  end

end
