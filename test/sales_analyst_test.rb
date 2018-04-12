require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

# Test class SalesAnalyst
class SalesAnalystTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv(
                              items:      './data/items.csv',
                              merchants:  './test/fixtures/merchants_fixtures.csv',
                              invoices:   './test/fixtures/invoices_fixtures.csv'
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
    assert_equal 0.99, @sa.average_invoices_per_merchant_standard_deviation
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
end
