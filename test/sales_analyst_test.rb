require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'date'

# This is a class for tests of the sales analyst class.
class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(
      items:     './test/fixtures/items_list_truncated.csv',
      merchants: './test/fixtures/merchants_list_truncated.csv',
      invoices:  './test/fixtures/invoices_list_truncated.csv',
      invoice_items: './test/fixtures/invoice_items_list_truncated.csv',
      transactions: './test/fixtures/transactions_list_truncated.csv',
      customers: './test/fixtures/customer_list_truncated.csv'
    )
    @sales_analyst = SalesAnalyst.new(@se)
  end

  def test_it_exists_and_sales_engine_argument
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_for_items_per_merchant
    expect = [1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0]
    actual = @sales_analyst.items_per_merchant
    assert_equal expect, actual
  end

  def test_for_invoices_per_merchant
    assert @sales_analyst.invoices_per_merchant.is_a?(Array)
    assert @sales_analyst.invoices_per_merchant[0].is_a?(Integer)
    assert_equal 1, @sales_analyst.invoices_per_merchant.first
    assert_equal 1, @sales_analyst.invoices_per_merchant.last
  end

  def test_for_average_items_per_merchant
    assert_equal 0.27, @sales_analyst.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    actual = @sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal 0.7, actual
  end

  def test_merchants_with_high_item_count
    actual = @sales_analyst.merchants_with_high_item_count

    assert actual.is_a?(Array)
    assert actual[0].is_a?(Merchant)
    assert_equal 4, actual.count
    assert_equal 'Shopin1901', actual[0].name
  end

  def test_for_average_item_price_for_merchant
    actual = @sales_analyst.average_item_price_for_merchant(12_334_185)

    assert actual.is_a?(BigDecimal)
    assert_equal 0.1117e2, actual
  end

  def test_find_average_price
    merchant1 = mock('merchant')
    merchant1.stubs(:items).returns([])
    merchant2 = mock('merchant')
    merchant2.stubs(:items).returns(['something'])
    merchant2.expects(:id).returns(12_334_112)

    assert_equal 0, @sales_analyst.find_average_price(merchant1)
    assert_equal 0.15e2, @sales_analyst.find_average_price(merchant2)
  end

  def test_for_average_average_price_per_merchant
    actual = @sales_analyst.average_average_price_per_merchant

    assert actual.is_a?(BigDecimal)
    assert_equal 0.309e1, actual
  end

  def test_for_item_unit_prices
    expected = [0.12e2, 0.13e2, 0.135e2, 0.7e1, 0.15e2, 0.2999e2, 0.149e3,
                0.149e2, 0.69e1, 0.4e3, 0.13e3, 0.399e1, 0.8e2, 0.6e3, 0.65e3,
                0.4e2, 0.239e2, 0.5e3, 0.239e2, 0.5e3, 0.5e1, 0.2e1, 0.35e1,
                0.406e3, 0.5e2]
    actual = @sales_analyst.item_unit_prices

    assert_equal expected, actual
  end

  def test_for_average_item_price
    actual = @sales_analyst.average_item_price

    assert_equal 147.1832, actual
  end

  def test_for_item_price_standard_deviation
    actual = @sales_analyst.item_price_standard_deviation

    assert_equal 215.88, actual
  end

  def test_for_golden_items
    actual = @sales_analyst.golden_items

    assert actual.is_a?(Array)
    assert actual[0].is_a?(Item)
    assert_equal 'Introspection virginalle', actual[0].name
  end

  def test_for_average_invoices_per_merchant
    assert_equal 0.23, @sales_analyst.average_invoices_per_merchant
  end

  def test_for_average_invoices_per_merchant_standard_deviation
    actual = @sales_analyst.average_invoices_per_merchant_standard_deviation
    assert_equal 0.53, actual
  end

  def test_for_top_merchants_by_invoice_count
    actual = @sales_analyst.top_merchants_by_invoice_count

    assert actual.is_a?(Array)
    assert actual[0].is_a?(Merchant)
    assert_equal 1, actual.count
    assert_equal 'Candisart', actual[0].name
  end

  def test_for_bottom_merchants_by_invoice_count
    actual = @sales_analyst.bottom_merchants_by_invoice_count

    assert actual.is_a?(Array)
    assert actual.empty?
    assert_equal 0, actual.count
  end

  def test_for_day_invoice_created
    assert @sales_analyst.day_invoice_created.is_a?(Array)
    assert_equal 'Saturday', @sales_analyst.day_invoice_created.first
    assert_equal 'Monday', @sales_analyst.day_invoice_created.last
    assert_equal 26, @sales_analyst.day_invoice_created.length
  end

  def test_for_days_of_week_invoice_count
    assert @sales_analyst.days_of_week_invoice_count.is_a?(Array)
    assert_equal 6, @sales_analyst.days_of_week_invoice_count.first
    assert_equal 1, @sales_analyst.days_of_week_invoice_count.last
    assert_equal 7, @sales_analyst.days_of_week_invoice_count.length
  end

  def test_for_average_invoices_per_day
    assert @sales_analyst.average_invoices_per_day.is_a?(Float)
    assert_equal 3.71, @sales_analyst.average_invoices_per_day
  end

  def test_invoices_per_day_standard_deviation
    assert @sales_analyst.invoices_per_day_standard_deviation.is_a?(Float)
    assert_equal 2.56, @sales_analyst.invoices_per_day_standard_deviation
  end

  def test_top_days_by_invoice_count
    actual = @sales_analyst.top_days_by_invoice_count

    assert actual.is_a?(Array)
    assert actual[0].is_a?(String)
    assert_equal 1, actual.count
    assert_equal 'Friday', actual[0]
  end

  def test_for_invoice_status
    assert_equal 34.62, @sales_analyst.invoice_status(:pending)
    assert_equal 53.85, @sales_analyst.invoice_status(:shipped)
    assert_equal 11.54, @sales_analyst.invoice_status(:returned)
  end

  def test_for_total_revenue_by_date
    date = Time.parse('2005-01-03')
    assert_equal 0.87909e3, @sales_analyst.total_revenue_by_date(date)
  end

  def test_for_top_revenue_earners
    assert @sales_analyst.top_revenue_earners.is_a?(Array)
    assert @sales_analyst.top_revenue_earners[0].is_a?(Merchant)

    assert_equal 20, @sales_analyst.top_revenue_earners.length
    assert_equal 7, @sales_analyst.top_revenue_earners(7).length
    assert_equal 12_334_105, @sales_analyst.top_revenue_earners.first.id
    assert_equal 12_334_123, @sales_analyst.top_revenue_earners.last.id
  end

  def test_total_item_prices
    invoice_item1 = mock('invoice_item')
    invoice_item1.stubs(:unit_price).returns(5)
    invoice_item1.stubs(:quantity).returns(2)

    invoice_item2 = mock('invoice_item')
    invoice_item2.stubs(:unit_price).returns(3)
    invoice_item2.stubs(:quantity).returns(4)

    invoice_item_array = [invoice_item1, invoice_item2]

    actual = @sales_analyst.find_total_item_prices(invoice_item_array)

    assert actual.is_a?(Array)
    assert_equal 2, actual.length
    assert_equal 10, actual.first
  end

  def test_for_revenue_by_merchant
    assert_equal 0.87909e3, @sales_analyst.revenue_by_merchant(12_334_105)
  end

  def test_for_merchants_total_revenue
    assert_equal 0.87909e3, @sales_analyst.merchants_total_revenue[0]
  end

  def test_for_merchants_ranked_by_revenue
    assert @sales_analyst.merchants_ranked_by_revenue.is_a?(Array)
    assert @sales_analyst.merchants_ranked_by_revenue[0].is_a?(Merchant)

    assert_equal 12_334_105, @sales_analyst.merchants_ranked_by_revenue[0].id
  end

  def test_for_merchants_with_pending_invoices
    assert @sales_analyst.merchants_with_pending_invoices.is_a?(Array)
    assert @sales_analyst.merchants_with_pending_invoices[0].is_a?(Merchant)

    assert_equal 3, @sales_analyst.merchants_with_pending_invoices.length
  end

  def test_for_merchants_with_only_one_item
    assert @sales_analyst.merchants_with_only_one_item.is_a?(Array)
    assert @sales_analyst.merchants_with_only_one_item[0].is_a?(Merchant)

    assert_equal 3, @sales_analyst.merchants_with_only_one_item.length
  end

  def test_for_merchants_with_only_one_item_registered_in_month
    act = @sales_analyst.merchants_with_only_one_item_registered_in_month('May')

    assert act.is_a?(Array)
    assert act[0].is_a?(Merchant)
    assert_equal 1, act.length
  end

  def test_for_most_sold_item_for_merchant
    expected = @sales_analyst.most_sold_item_for_merchant(12_334_105)
    assert expected[0].is_a?(Item)

    assert_equal 263_506_360, expected[0].id
  end

  def test_search_invoice_items_by_quantity
    invoice_item1 = mock('invoice_item')
    invoice_item1.stubs(:quantity).returns(5)
    invoice_item1.stubs(:id).returns(29)
    invoice_item2 = mock('invoice_item')
    invoice_item2.stubs(:quantity).returns(7)
    ii_array = [invoice_item1, invoice_item2]
    actual = @sales_analyst.search_invoice_items_by_quantity(ii_array, 5)

    assert actual.is_a?(Array)
    assert_equal 29, actual[0].id
    assert_equal 1, actual.length
  end

  def test_best_item_for_merchant
    expected = @sales_analyst.best_item_for_merchant(12_334_105)

    assert_instance_of Item, expected
    assert_equal 263_506_360, expected.id
  end

  def test_sort_invoice_items_by_total_revenue
    invoice_item1 = mock('invoice_item')
    invoice_item1.stubs(:unit_price).returns(5)
    invoice_item1.stubs(:quantity).returns(2)

    invoice_item2 = mock('invoice_item')
    invoice_item2.stubs(:unit_price).returns(3)
    invoice_item2.stubs(:quantity).returns(4)

    invoice_items = [invoice_item1, invoice_item2]

    actual = @sales_analyst.sort_invoice_items_by_total_revenue(invoice_items)

    assert_equal 3, actual.unit_price
  end

  def test_top_buyers
    assert_equal 2, @sales_analyst.top_buyers(2).length
    assert_equal 5, @sales_analyst.top_buyers(3).first.id

    assert_equal 20, @sales_analyst.top_buyers.length
    assert_equal 3, @sales_analyst.top_buyers.last.id
  end

  def test_get_invoices_for_customer
    assert @sales_analyst.get_invoices_for_customer(339).is_a?(Array)
    assert @sales_analyst.get_invoices_for_customer(339)[0].is_a?(Invoice)
    assert_equal 1695, @sales_analyst.get_invoices_for_customer(339)[0].id
  end

  def test_top_merchant_for_customer
    expected = @se.merchants.find_by_id(123_359_38)

    assert_equal expected, @sales_analyst.top_merchant_for_customer(1)
  end

  def test_one_time_buyers
    expected = @se.customers.find_by_id(5)

    assert_equal 3, @sales_analyst.one_time_buyers.length
    assert_equal expected, @sales_analyst.one_time_buyers.first
  end

  def test_one_time_buyers_top_items
    assert_equal 1, @sales_analyst.one_time_buyers_top_items.length
    assert_equal 263_504_126, @sales_analyst.one_time_buyers_top_items.first.id
  end

  def test_find_fully_paid_invoices
    customer = mock('customer')
    invoice1 = mock('invoice')
    customer.stubs(:fully_paid_invoices).returns([invoice1])

    invoice_item1 = mock('invoice_item')
    invoice_item1.stubs(:unit_price).returns(5)
    invoice_item1.stubs(:quantity).returns(2)
    invoice_item1.stubs(:item_id).returns(26_352_926)
    invoice1.stubs(:invoice_items).returns([invoice_item1])

    actual = @sales_analyst.find_fully_paid_invoices(customer, Hash.new(0))

    assert_equal [invoice1], actual
  end

  def test_find_quantities
    invoice_item1 = mock('invoice_item')
    invoice_item1.expects(:item_id).returns('263_519_844')
    invoice_item1.expects(:quantity).returns(5)
    invoice_item2 = mock('invoice_item')
    invoice_item2.expects(:item_id).returns('263_563_764')
    invoice_item2.expects(:quantity).returns(7)
    invoice = mock('invoice')
    invoice.stubs(:invoice_items).returns([invoice_item1, invoice_item2])
    actual = @sales_analyst.find_quantities(invoice, Hash.new(0))

    assert_equal [invoice_item1, invoice_item2], actual
  end

  def test_items_bought_in_year
    assert_equal 0, @sales_analyst.items_bought_in_year(1, 2012).length
    actual = @sales_analyst.items_bought_in_year(1, 2009)
    assert_equal 263_519_844, actual.first.id
  end

  def test_highest_volume_items
    assert_equal 1, @sales_analyst.highest_volume_items(1).length
    assert_equal 263_454_779, @sales_analyst.highest_volume_items(1).first.id
    assert_equal Item, @sales_analyst.highest_volume_items(1).first.class
  end

  def test_customers_with_unpaid_invoices
    assert_equal 6, @sales_analyst.customers_with_unpaid_invoices.length
    assert_equal 1, @sales_analyst.customers_with_unpaid_invoices.first.id
    assert_equal 339, @sales_analyst.customers_with_unpaid_invoices.last.id
  end

  def test_best_invoice_by_revenue
    assert_instance_of Invoice, @sales_analyst.best_invoice_by_revenue
    assert_equal 19, @sales_analyst.best_invoice_by_revenue.id
  end

  def test_best_invoice_by_quantity
    assert_instance_of Invoice, @sales_analyst.best_invoice_by_quantity
    assert_equal 19, @sales_analyst.best_invoice_by_quantity.id
  end
end
