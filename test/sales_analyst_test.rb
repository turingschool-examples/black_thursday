require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'
class SalesAnalystTest < Minitest::Test
  def setup
    merchant_path = './data/merchants.csv'
    item_path = './data/items.csv'
    invoice_items_path = './data/invoice_items.csv'
    customers_path = "./data/customers.csv"
    transactions_path = "./data/transactions.csv"
    invoices_path = './data/invoices.csv'
    locations = { items: item_path,
                  merchants: merchant_path,
                  invoice_items: invoice_items_path,
                  customers: customers_path,
                  transactions: transactions_path,
                  invoices: invoices_path}
    sales_engine = SalesEngine.from_csv(locations)
    @sales_analyst = sales_engine.analyst
  end
  def test_it_exists_and_has_attributes
    skip
    assert_instance_of SalesAnalyst, @sales_analyst
    assert_instance_of SalesEngine, @sales_analyst.sales_engine
  end
  def test_it_can_return_average_items_per_merchant
    skip
    assert_equal 2.88, @sales_analyst.average_items_per_merchant
  end
  def test_it_can_return_average_items_per_merchant_standard_deviation
    skip
    assert_equal 3.26, @sales_analyst.average_items_per_merchant_standard_deviation
  end
  def test_it_can_return_merchants_with_high_items_count
    skip
    assert_equal 52, @sales_analyst.merchants_with_high_item_count.length
    assert_instance_of Merchant, @sales_analyst.merchants_with_high_item_count.last
  end
  def test_it_can_find_average_average_price_per_merchant
    skip
    assert_equal 350.29, @sales_analyst.average_average_price_per_merchant
  end
  def test_it_can_return_golden_items
    skip
    assert_equal 5, @sales_analyst.golden_items.length
    assert_instance_of Item, @sales_analyst.golden_items.first
  end
  def test_average_item_price_for_merchant
    skip
    assert_equal 16.66, @sales_analyst.average_item_price_for_merchant(12334105)
  end
  def test_it_can_return_total_items
    skip
    assert_equal 1367, @sales_analyst.total_items
  end
  def test_it_can_return_total_merchants
    skip
    assert_equal 475, @sales_analyst.total_merchants
  end
  def test_it_calculates_average_item_price
    skip
    assert_equal 251.06, @sales_analyst.average_item_price
  end
  def test_it_calculates_item_price_standard_deviation
    skip
    assert_equal 2900.99, @sales_analyst.item_price_standard_deviation
  end
  def test_returns_all_invoices
    skip
    assert_equal 4985, @sales_analyst.total_invoices
  end

  def test_average_invoices_per_merchant
    skip
    assert_equal 10.49, @sales_analyst.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    skip
    assert_equal 3.29, @sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    skip
    assert_equal 12, @sales_analyst.top_merchants_by_invoice_count.length
  end

  def test_bottom_merchants_by_invoice_count
    skip
    assert_equal 4, @sales_analyst.bottom_merchants_by_invoice_count.length
  end

  def test_average_invoices_per_day
    skip
    assert_equal 712, @sales_analyst.average_invoices_per_day
  end

  def test_average_invoices_per_day_standard_deviation
    skip
    assert_equal 18.07, @sales_analyst.average_invoices_per_day_standard_deviation
  end

  def test_top_days_by_invoice_count
    skip
    assert_equal ["Wednesday"], @sales_analyst.top_days_by_invoice_count
  end

  def test_invoice_status_returns_percentage
    skip
    assert_equal 29.55, @sales_analyst.invoice_status(:pending)
    assert_equal 56.95, @sales_analyst.invoice_status(:shipped)
    assert_equal 13.5, @sales_analyst.invoice_status(:returned)
  end
  def test_it_can_determine_invoice_paid_in_full
    skip
    assert_equal true, @sales_analyst.invoice_paid_in_full?(1)
  end

  def test_it_can_return_invoice_total
    skip
    assert_equal 21067.77, @sales_analyst.invoice_total(1)
  end

  def test_it_can_return_revenue_by_date
    skip
    assert_equal 21067.77, @sales_analyst.total_revenue_by_date(Time.parse("2009-02-07"))
  end

  def test_it_can_return_top_revenue_earners
    skip
    assert_equal 12334634, @sales_analyst.top_revenue_earners.first.id
  end

  def test_it_can_return_all_merchants_with_total_revenues
    skip
    assert_equal 475, @sales_analyst.all_merchants_with_total_revenues.count
  end

  def test_it_can_find_merchants_with_pending_invoices
    assert_equal 467, @sales_analyst.merchants_with_pending_invoices.length
  end

  def test_it_can_get_pending_invoices
    assert_equal 467, @sales_analyst.pending_invoices.length
  end

  def test_find_ids_for_one_item
    skip
    assert_equal 243, @sales_analyst.find_ids_for_one_item.length
  end

  def test_merchant_with_only_one_item
    skip
    assert_instance_of Array, @sales_analyst.merchants_with_only_one_item
    assert_equal 243, @sales_analyst.merchants_with_only_one_item.length
  end

  def test_merchants_with_only_item_registered_in_month
    skip
    assert_instance_of Array, @sales_analyst.test_merchants_with_only_item_registered_in_month("March")
  end

  def test_revenue_by_merchant_returns_big_decimal_for_given_merchant
    assert_instance_of BigDecimal, @sales_analyst.revenue_by_merchant(12334194)
  end

  def test_item_quantity_for_merchant
    assert_equal 40, @sales_analyst.item_quantity_for_merchant(12334194).length
  end

  def test_return_merchant_invoice_ids
    test_ids = [180, 1214, 1666,
                1785, 2423, 2472,
                2752, 2999, 3979,
                4234, 4695, 4955, 4958]

    assert_equal test_ids, @sales_analyst.return_merchant_invoice_ids(12334194)
  end

  def test_most_sold_item_by_id_for_merchant
    assert_equal [263545484, 263521128, 263526484], @sales_analyst.most_sold_item_by_id_for_merchant(12334194)
  end

  def test_most_sold_item_for_merchant
    assert_equal 3, @sales_analyst.most_sold_item_for_merchant(12334194).length
  end

  def test_item_value_totals
    assert_equal 40, @sales_analyst.item_value_totals(12334194).length
  end

  def test_best_item_for_merchant
    assert_equal 24995.0, @sales_analyst.best_item_for_merchant(12334194).unit_price_to_dollars
  end
end
