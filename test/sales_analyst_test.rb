require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test 

  attr_reader :engine, :analyst

  def setup
    @engine = SalesEngine.from_csv({:items => './test/assets/test_items.csv', 
                                    :merchants => './test/assets/test_merchants.csv', 
                                    :invoices => "./test/assets/test_invoices.csv", 
                                    :invoice_items => "./test/assets/test_invoice_items.csv",
                                    :transactions => "./test/assets/test_transactions.csv",
                                    :customers => "./test/assets/test_customers.csv"})
    @analyst =  SalesAnalyst.new(engine)
  end

  def test_engine_is_accessible_from_analyst
    assert_equal 31, analyst.engine.merchants.all.count
  end

  def test_analyst_returns_average_items_per_merchant
    assert_equal 2.13, analyst.average_items_per_merchant.round(2)
  end

  def test_analyst_returns_average_items_per_merchant_standard_deviation
    assert_equal 1.86, analyst.average_items_per_merchant_standard_deviation.round(2)
  end

  def test_that_stdev_method_works
    array = [13, 22, 23, 50]
    expected = 13.838352503098047
    assert_equal expected, analyst.stdev(array)
  end

  def test_it_averages_arrays
    array = [13, 22, 23, 50]
    assert_equal 27, analyst.find_average(array)
  end

  def test_it_returns_high_item_count
    expected_array = ["Shopin1901 : 6", "Candisart : 4", "MiniatureBikez : 4", "LolaMarleys : 5", "perlesemoi : 5", "Urcase17 : 5", "BowlsByChris : 4", "NicSueDesigns : 4"]
    found_merchants = analyst.merchants_with_high_item_count.map { |merchant| "#{merchant.name} : #{merchant.items.count}"}
    assert_equal expected_array, found_merchants
  end

  def test_it_finds_average_price_of_one_merchant
    assert_equal 115.66, analyst.average_item_price_for_merchant(55).to_f
  end

  def test_analyst_finds_average_average_price_per_merchant
    assert_equal 100.42, analyst.average_average_price_per_merchant.to_f
  end

  def test_it_finds_golden_items_of_all_items
    golden_array = ["Solid Cherry Trestle Table : 5500.0"]
    found_items = analyst.golden_items.map { |item| "#{item.name} : #{item.unit_price_as_dollars}"}
    assert_equal golden_array, found_items
  end

  def test_analyst_finds_average_invoices_per_merchant
    assert_equal 1.65, analyst.average_invoices_per_merchant
  end

  def test_it_finds_stdev_of_average_invoices_per_merchant
    assert_equal 1.18, analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_analyst_returns_top_performing_merchants_two_stdevs_over_average
    top_merchant = ["GeorgiaFayeDesigns"]
    found_merchants = analyst.top_merchants_by_invoice_count
    assert_equal top_merchant, found_merchants.map {|merchant| merchant.name}
  end

  def test_analyst_returns_bottom_performing_merchants_two_stdevs_under_average
    lowest_merchants = []
    found_merchants = analyst.bottom_merchants_by_invoice_count
    assert_equal lowest_merchants, found_merchants.map {|merchant| merchant.name}
  end

  def test_it_find_top_days_for_sales
    assert_equal ['Saturday'], analyst.top_days_by_invoice_count
  end

  def test_invoice_status_returns_percentage_with_status
    assert_equal 41.07, analyst.invoice_status(:pending)
  end

  def test_total_revnue_by_date
    assert_equal 6444.38, analyst.total_revenue_by_date(Time.parse("2012-03-27")).to_f
  end

  def test_find_top_revenue_merchants
    expected = 55
    result = analyst.top_revenue_earners(4).map {|merchant| merchant.id}
    assert_equal 4, result.count
    assert_equal expected, result.first
  end

  def test_find_top_merchants_returns_twenty_merchants_by_default
    assert_equal 20, analyst.top_revenue_earners.count
  end

  def test_it_finds_revenue_for_single_merchant
    assert_equal 6832.23, analyst.revenue_by_merchant(56).to_f
  end

  def test_returning_merchants_with_pending_invoices
    assert_equal 10, analyst.merchants_with_pending_invoices.count
  end

  def test_it_returns_merchants_with_one_item
    assert_equal 3, analyst.merchants_with_only_one_item.count
  end

  def test_finding_merchants_with_one_item_in_first_month
    assert_equal 1, analyst.merchants_with_only_one_item_registered_in_month("june").count
  end

  def test_merchants_ranked_by_revenue_returns_all_ranked_merchants
    result = analyst.merchants_ranked_by_revenue
    assert_equal 27, result.count
    assert_equal 55, result.first.id
    assert_equal 9, result.last.id
  end

  def test_finding_items_by_merchant
    desired_merchant = analyst.engine.merchants.find_by_id(55)
    assert_equal 3, desired_merchant.items.count
  end

  def test_finding_customers_by_merchant
    desired_merchant = analyst.engine.merchants.find_by_id(50)
    assert_equal 1, desired_merchant.customers.count
  end

  def test_finding_merchant_by_item
    desired_item = analyst.engine.items.find_by_id(56)
    assert_equal 51, desired_item.merchant.id
  end

  def test_finding_items_by_invoice
    desired_invoice = analyst.engine.invoices.find_by_id(18)
    assert_equal 3, desired_invoice.items.count
  end

  def test_finding_transactions_by_invoice
    desired_invoice = analyst.engine.invoices.find_by_id(18)
    assert_equal 1, desired_invoice.transactions.count
  end

  def test_finding_customer_by_invoice
    desired_invoice = analyst.engine.invoices.find_by_id(18)
    assert_equal 10, desired_invoice.customer.id
  end

  def test_invoice_is_paid_in_full
    desired_invoice = analyst.engine.invoices.find_by_id(18)
    assert_equal true, desired_invoice.is_paid_in_full?
  end

  def test_finding_merchants_by_customers
    desired_customer = analyst.engine.customers.find_by_id(5)
    assert_equal 1, desired_customer.merchants.count
  end

  def test_finding_invoice_by_transaction
    desired_transaction = analyst.engine.transactions.find_by_id(3)
    assert_equal 28, desired_transaction.invoice.id
  end

  def test_analyst_finds_most_sold_item_for_a_merchant
    result = analyst.most_sold_item_for_merchant(55)
    assert_equal 1, result.count
  end

  def test_analyst_returns_best_item_for_merchant
    assert_equal 58, analyst.best_item_for_merchant(55).id
  end
end