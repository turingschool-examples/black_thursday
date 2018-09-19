require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  def test_it_exists
    new_salesanalyst = SalesAnalyst.new('ir', 'mr', 'inv_repo', 'ii', 'tr')

    assert_instance_of SalesAnalyst, new_salesanalyst
  end

  def test_that_sales_analyst_initializes_with_repositories
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",

    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",})
    sales_analyst = se.analyst

    assert_instance_of MerchantRepository, sales_analyst.mr
    assert_instance_of ItemRepository, sales_analyst.ir
    assert_instance_of InvoiceRepository, sales_analyst.inv_repo
    assert_instance_of InvoiceItemRepository, sales_analyst.ii
    assert_instance_of TransactionRepository, sales_analyst.tr
  end

  def test_it_calculates_average_items_per_merchant
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    sales_analyst = se.analyst

    assert_equal 2.88, sales_analyst.average_items_per_merchant

  end

  def test_it_calculates_standard_deviation
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    sales_analyst = se.analyst

    assert_equal 3.26, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_returns_merchants_more_than_one_standard_deviation
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    sales_analyst = se.analyst

    assert_equal 52, sales_analyst.merchants_with_high_item_count.count
  end

  def test_sales_analyst_calculates_merchant_average_item_price
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    sales_analyst = se.analyst

    actual = sales_analyst.average_item_price_for_merchant(12334105)
    assert_instance_of BigDecimal, actual
    assert_equal 16.66, (actual.to_f).round(2)
  end

  def test_that_sales_analyst_average_average_price_per_merchant
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    sales_analyst = se.analyst

    actual = sales_analyst.average_average_price_per_merchant
    assert_instance_of BigDecimal, actual
    assert_equal 350.29, (actual.to_f).round(2)
  end

  def test_that_golden_items_returns_most_expensive_items
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    sales_analyst = se.analyst

    actual = (sales_analyst.golden_items).count
    assert_equal 5, actual
    assert_instance_of Item, sales_analyst.golden_items[0]
  end

  def test_that_average_invoices_per_merchant_returns_average
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    sales_analyst = se.analyst

    actual = sales_analyst.average_invoices_per_merchant
    assert_equal 10.49, actual
  end

  def test_average_invoices_per_merchant_standard_deviation
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    sales_analyst = se.analyst

    actual = sales_analyst.average_invoices_per_merchant_standard_deviation
    assert_equal 3.29, actual
  end

  def test_top_merchants_by_invoice_count_returns_top_merchants
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    sales_analyst = se.analyst

    actual = sales_analyst.top_merchants_by_invoice_count
    assert_equal 12, actual.count
    assert_instance_of Merchant, actual[5]
  end

  def test_bottom_merchants_by_invoice_count_returns_bottom_merchants
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    sales_analyst = se.analyst

    actual = sales_analyst.bottom_merchants_by_invoice_count
    assert_equal 4, actual.count
    assert_instance_of Merchant, actual[3]
  end

  def test_top_days_by_invoice_count_returns_top_days_for_sales
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    sales_analyst = se.analyst

    actual = sales_analyst.top_days_by_invoice_count
    assert_equal 1, actual.count
    assert_equal "Wednesday", actual[0]
  end

  def test_invoice_status_returns_percentage_of_each_status
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    sales_analyst = se.analyst

    pending_percentage = sales_analyst.invoice_status(:pending)
    shipped_percentage = sales_analyst.invoice_status(:shipped)
    returned_percentage = sales_analyst.invoice_status(:returned)

    assert_equal 29.55, pending_percentage
    assert_equal 56.95, shipped_percentage
    assert_equal 13.5, returned_percentage
  end

  def test_invoice_paid_in_full_returns_true_of_false_based_transaction_results
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    sales_analyst = se.analyst

    assert sales_analyst.invoice_paid_in_full?(1)
    assert sales_analyst.invoice_paid_in_full?(200)
    refute sales_analyst.invoice_paid_in_full?(203)
    refute sales_analyst.invoice_paid_in_full?(204)
  end

  def test_invoice_total_gives_total_revenue_for_invoices
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    sales_analyst = se.analyst

    assert_equal 21067.77, sales_analyst.invoice_total(1)
    assert_instance_of BigDecimal, sales_analyst.invoice_total(1)

  end

  def test_total_revenue_by_date_returns_total_revenue_for_invoices
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    sales_analyst = se.analyst

    date = Time.parse("2009-02-07")
    expected = sales_analyst.total_revenue_by_date(date)

    assert_equal 21067.77, expected
    assert_instance_of BigDecimal, expected
  end

  def test_that_top_revenue_earners_returns_array_of_such
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    sales_analyst = se.analyst

    expected = sales_analyst.top_revenue_earners(10)

    assert_equal 10, expected.count
    assert_instance_of Merchant, expected.first
    assert_equal 12334634, expected.first.id
    assert_equal 12335747, expected.last.id
  end

  def test_that_top_revenue_earners_defaults_to_20_merchants
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    sales_analyst = se.analyst

    expected = sales_analyst.top_revenue_earners

    assert_equal 20, expected.count
    assert_instance_of Merchant, expected.first
    assert_equal 12334634, expected.first.id
    assert_equal 12334159, expected.last.id
  end

  def test_merchants_with_pending_invoices_returns_merchants_with_pending_invs
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    sales_analyst = se.analyst

    actual = sales_analyst.merchants_with_pending_invoices

    assert_equal 467, actual.count
    assert_instance_of Merchant, actual.first
  end

  def test_merchants_with_only_one_item_returns_merchants_with_one_item
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    sales_analyst = se.analyst

    actual = sales_analyst.merchants_with_only_one_item

    assert_equal 243, actual.count
    assert_instance_of Merchant, actual.first
  end

  def test_merchants_with_only_one_item_registered_in_month
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    sales_analyst = se.analyst

    actual = sales_analyst.merchants_with_only_one_item_registered_in_month("March")

    assert_equal 21, actual.count
    assert_instance_of Merchant, actual.first
  end

  def test_that_revenue_by_merchant_returns_individual
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    sales_analyst = se.analyst
    top_five = sales_analyst.top_revenue_earners(5)

    top_5_total_revenue = top_five.max_by(5) do |merchant|
       bigD = sales_analyst.revenue_by_merchant(merchant.id)
    end
    assert top_five == top_5_total_revenue
  end

  def test_that_most_sold_items_for_merchant_returns_most_sold_item
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :customers => "./data/customers.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"})
    top_items = se.analyst.most_sold_item_for_merchant(12334189)
    top_4_items = se.analyst.most_sold_item_for_merchant(12337105)

    assert top_items.map(&:id).include?(263524984)
    assert top_items.map(&:name).include?("Adult Princess Leia Hat")
    assert_equal 4, top_4_items.count
  end
end
