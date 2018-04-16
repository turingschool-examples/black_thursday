require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

# Test class SalesAnalyst
class SalesAnalystTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv(
      items:          './data/items.csv',
      merchants:      './test/fixtures/merchants_fixtures.csv',
      invoices:       './test/fixtures/invoices_fixtures.csv',
      invoice_items:  './test/fixtures/invoice_items_fixtures.csv',
      transactions:   './test/fixtures/transactions_fixtures.csv'
    )
    @sa = se.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_can_return_average_items_per_merchant
    assert_equal 27.9, @sa.average_items_per_merchant
  end

  def test_it_can_return_items_per_merchant_standard_deviation
    assert_equal 25.08, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_return_merchants_with_high_item_count
    se = SalesEngine.from_csv(
      items:      './data/items.csv',
      merchants:  './data/merchants.csv',
      invoices:   './data/invoices.csv'
    )
    sa = se.analyst
    top_sellers = sa.merchants_with_high_item_count
    assert_instance_of Array, top_sellers
    m1 = top_sellers[0]
    assert_instance_of Merchant, m1
    m1_items = sa.engine.items.find_all_by_merchant_id(m1.id)
    assert m1_items.count > (2.88 + (3.26 * 2))
    assert_instance_of Merchant, top_sellers[5]
    assert_instance_of Merchant, top_sellers[-1]
    refute top_sellers.include?(sa.engine.merchants.find_by_id(12335009))
  end

  def test_average_item_price_for_merchant
    average = @sa.average_item_price_for_merchant(12334105)
    assert_instance_of BigDecimal, average
    assert_equal 16.66, average
  end

  def test_average_average_price_per_merchant
    average = @sa.average_average_price_per_merchant
    assert_instance_of BigDecimal, average
    assert_equal 63.09, average
  end

  def test_average_item_cost
    assert_equal 251.06, @sa.average_item_cost
  end

  def test_unit_price_standard_deviation
    assert_equal 2900.99, @sa.item_unit_price_standard_deviation
  end

  def test_golden_items
    golden = @sa.golden_items
    assert_instance_of Array, golden
    assert_instance_of Item, golden[0]
    assert_instance_of Item, golden[-1]
    assert golden.include?(@sa.engine.items.find_by_id(263554072))
    refute golden.include?(@sa.engine.items.find_by_id(263529916))
  end

  def test_it_returns_average_invoices_per_merchant
    assert_equal 1.02, @sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 0.98, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    se = SalesEngine.from_csv(
      items:      './data/items.csv',
      merchants:  './data/merchants.csv',
      invoices:   './data/invoices.csv'
    )
    sa = se.analyst
    top_sellers = sa.top_merchants_by_invoice_count
    assert_instance_of Array, top_sellers
    m1 = top_sellers[0]
    assert_instance_of Merchant, m1
    m1_invoices = sa.engine.invoices.find_all_by_merchant_id(m1.id)
    assert m1_invoices.count > (10.49 + (3.29 * 2))
    assert_instance_of Merchant, top_sellers[5]
    assert_instance_of Merchant, top_sellers[-1]
    refute top_sellers.include?(sa.engine.merchants.find_by_id(12334213))
    assert top_sellers.include?(sa.engine.merchants.find_by_id(12334141))
  end

  def test_bottom_merchants_by_invoice_count
    se = SalesEngine.from_csv(
      items:      './data/items.csv',
      merchants:  './data/merchants.csv',
      invoices:   './data/invoices.csv'
    )
    sa = se.analyst
    lowest_sellers = sa.bottom_merchants_by_invoice_count
    assert_instance_of Array, lowest_sellers
    m1 = lowest_sellers[0]
    assert_instance_of Merchant, m1
    m1_invoices = sa.engine.invoices.find_all_by_merchant_id(m1.id)
    assert m1_invoices.count < (10.49 - (3.29 * 2))
    assert_instance_of Merchant, lowest_sellers[0]
    assert_instance_of Merchant, lowest_sellers[-1]
    refute lowest_sellers.include?(sa.engine.merchants.find_by_id(12334141))
    assert lowest_sellers.include?(sa.engine.merchants.find_by_id(12334235))
  end

  def test_average_days
    days = { 6 => 729, 5 => 701, 3 => 741, 1 => 696, 0 => 708, 2 => 692,
             4 => 718 }
    assert_equal 712, @sa.average_days(days)
  end

  def test_generate_day
    days = { 6 => 9, 5 => 12, 3 => 1, 1 => 7, 0 => 5, 2 => 9, 4 => 7 }
    assert_equal days, @sa.generate_day
  end

  def test_top_days_by_invoice_count
    assert_equal ['Friday'], @sa.top_days_by_invoice_count
  end

  def test_percentage_of_invoices_with_given_status
    assert_equal 34.0, @sa.invoice_status(:pending)
    assert_equal 60.0, @sa.invoice_status(:shipped)
    assert_equal 6.0, @sa.invoice_status(:returned)
  end

  def test_invoice_by_day_standard_deviation
    assert_equal 3.49, @sa.invoice_by_day_standard_deviation
  end
  def test_it_can_check_if_invoice_paid_in_full
    assert @sa.invoice_paid_in_full?(46)
    refute @sa.invoice_paid_in_full?(40)
  end

  def test_it_can_return_invoice_total
    actual = @sa.invoice_total(1)
    assert_equal 21067.77, actual
    assert_instance_of BigDecimal, actual
  end

  def test_it_can_return_total_revenue_by_date
    se = SalesEngine.from_csv(
      invoices:   './data/invoices.csv',
      invoice_items: './data/invoice_items.csv'
    )
    actual = se.analyst.total_revenue_by_date(Time.parse('2009-02-07'))
    assert_equal 21067.77, actual
    assert_instance_of BigDecimal, actual
  end

  def test_it_returns_top_merchants_by_revenue
    se = SalesEngine.from_csv(
      invoices:   './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      merchants: './data/merchants.csv',
      transactions: './data/transactions.csv'
    )
    actual = se.analyst.top_revenue_earners(10)
    assert_instance_of Array, actual
    assert_equal 10, actual.length
    assert_instance_of Merchant, actual[0]
    assert_equal 12334634, actual[0].id
    assert_instance_of Merchant, actual[-1]
    assert_equal 12335747, actual[-1].id
  end

  def test_it_ranks_merchants
    se = SalesEngine.from_csv(
      invoices:   './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      merchants: './data/merchants.csv',
      transactions: './data/transactions.csv'
    )
    actual = se.analyst.merchants_ranked_by_revenue
    assert_instance_of Array, actual
    assert_instance_of Merchant, actual[0]
    assert_equal 12334634, actual[0].id
    assert_instance_of Merchant, actual[-1]
    assert_equal 12336175, actual[-1].id
  end

  def test_it_returns_merchants_with_pending_invoices
    se = SalesEngine.from_csv(
      invoices:   './data/invoices.csv',
      merchants: './data/merchants.csv',
      transactions: './data/transactions.csv'
    )
    actual = se.analyst.merchants_with_pending_invoices
    assert_instance_of Array, actual
    assert_instance_of Merchant, actual[0]
    assert_equal 467, actual.count
  end

  def test_it_returns_merchants_with_only_one_item
    se = SalesEngine.from_csv(
      items:      './data/items.csv',
      merchants: './data/merchants.csv'
    )
    actual = se.analyst.merchants_with_only_one_item
    assert_instance_of Array, actual
    assert_instance_of Merchant, actual[0]
    assert_equal 243, actual.count
  end

  def test_it_returns_merchants_with_only_one_item_registered_in_month
    se = SalesEngine.from_csv(
      items:      './data/items.csv',
      invoices:   './data/invoices.csv',
      merchants: './data/merchants.csv'
      )
    actual1 = se.analyst.merchants_with_only_one_item_registered_in_month('March')
    assert_instance_of Array, actual1
    assert_instance_of Merchant, actual1[0]
    assert_equal 21, actual1.count

    actual2 = se.analyst.merchants_with_only_one_item_registered_in_month('June')
    assert_instance_of Array, actual2
    assert_instance_of Merchant, actual2[0]
    assert_equal 18, actual2.count
  end

  def test_it_returns_revenue_by_merchant
    se = SalesEngine.from_csv(
      invoices:   './data/invoices.csv',
      merchants: './data/merchants.csv'
    )
    actual = se.analyst.revenue_by_merchant(12334194)
    assert_instance_of BigDecimal, actual
  end

  def test_it_returns_most_sold_item_for_a_merchant
    se = SalesEngine.from_csv(
      invoices:         './data/invoices.csv',
      items:            './data/items.csv',
      invoice_items:    './data/invoice_items.csv',
      transactions:     './data/transactions.csv',
      merchants:        './data/merchants.csv'
    )
    actual = se.analyst.most_sold_item_for_merchant(12334189)
    assert_instance_of Array, actual
    item = se.items.find_by_id(263524984)
    assert actual.include?(item)
    assert_instance_of Item, actual[0]

    actual = se.analyst.most_sold_item_for_merchant(12337105)
    assert_equal 4, actual.length
  end

  def test_it_returns_best_item_for_merchant
    skip
    se = SalesEngine.from_csv(
      invoices:         './data/invoices.csv',
      items:            './data/items.csv',
      invoice_items:    './data/invoice_items.csv',
      merchants:        './data/merchants.csv'
    )
    actual = se.analyst.best_item_for_merchant(12334189)

  end
end
