require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/sales_analyst'
require './lib/invoice_repo'
require './lib/invoice'
require 'pry'

class SalesAnalystTest < Minitest::Test

  def test_it_exists
    sales_engine = SalesEngine.from_csv({
                                :items     => "./fixtures/items_sample.csv",
                                :merchants => "./fixtures/merchant_sample.csv"
                                })
    sales_analyst = sales_engine.analyst
    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_it_can_average_items_per_merchant_sample
    sales_engine = SalesEngine.from_csv({
                                :items     => "./fixtures/sales_analyst_items_sample.csv",
                                :merchants => "./fixtures/sales_analyst_merchants_sample.csv"
                                })

    sales_analyst = sales_engine.analyst
    assert_equal 1.67, sales_analyst.average_items_per_merchant
  end

  def test_average_for_whole_data_set
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv"
                              })

    sales_analyst = sales_engine.analyst
    assert_equal 2.88, sales_analyst.average_items_per_merchant
  end

  def test_for_standard_deviation
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv"
                              })

    sales_analyst = sales_engine.analyst
    assert_equal 3.26, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_for_merchants_with_high_item_count
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv"
                              })
    sales_analyst = sales_engine.analyst
    expected = sales_analyst.merchants_with_high_item_count
    assert_equal 52, expected.count
  end

  def test_average_item_price_for_a_merchant
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv"
                              })
    sales_analyst = sales_engine.analyst
    expected = sales_analyst.average_item_price_for_merchant(12334105)
    assert_equal 16.66, expected
    assert_equal BigDecimal, expected.class
  end

  def test_average_average_price_per_merchant
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv"
                              })
    sales_analyst = sales_engine.analyst
    assert_equal 350.29, sales_analyst.average_average_price_per_merchant
  end

  def test_golden_items
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv"
                              })
    sales_analyst = sales_engine.analyst
    expected = sales_analyst.golden_items
    assert_equal 5, expected.length
    assert_equal Item, expected.first.class
  end

  def test_average_invoices_per_merchant
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv"
                              })
    sales_analyst = sales_engine.analyst
    expected = sales_analyst.average_invoices_per_merchant
    assert_equal 10.49, expected
  end

  def test_for_average_invoice_per_merchant_standard_deviation
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv"
                              })
    sales_analyst = sales_engine.analyst
    expected = sales_analyst.average_invoices_per_merchant_standard_deviation
    assert_equal 3.29, expected
  end

  def test_for_top_performing_merchants
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv"
                              })
    sales_analyst = sales_engine.analyst
    expected = sales_analyst.top_merchants_by_invoice_count
    assert_equal 12, expected.length
  end

  def test_for_lowest_performing_merchants
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv"
                              })
    sales_analyst = sales_engine.analyst
    expected = sales_analyst.bottom_merchants_by_invoice_count
    assert_equal 4, expected.length
  end

  def test_which_days_see_the_most_sales
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv"
                              })
    sales_analyst = sales_engine.analyst
    expected = sales_analyst.top_days_by_invoice_count
    assert_equal 1, expected.length
    assert_equal "Wednesday", expected.first
  end

  def test_percentage_of_unshipped_invoices
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv"
                              })
    sales_analyst = sales_engine.analyst
    expected = sales_analyst.invoice_status(:pending)
    assert_equal 29.55, expected
    results = sales_analyst.invoice_status(:shipped)
    assert_equal 56.95, results
    returned = sales_analyst.invoice_status(:returned)
    assert_equal 13.5, returned
  end

  def test_if_invoice_is_paid_in_full?
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv",
                              :transactions => "./data/transactions.csv",
                              :invoice_items => "./data/invoice_items.csv",
                              :customers => "./data/customers.csv"
                              })
    sales_analyst = sales_engine.analyst
    assert_equal true, sales_analyst.invoice_paid_in_full?(1)
    assert_equal true, sales_analyst.invoice_paid_in_full?(200)
    assert_equal false, sales_analyst.invoice_paid_in_full?(203)
    assert_equal false, sales_analyst.invoice_paid_in_full?(204)
  end

  def test_it_returns_total_dollar_amount_if_invoice_is_paid_in_full
    sales_engine = SalesEngine.from_csv({
                              :items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv",
                              :invoices => "./data/invoices.csv",
                              :transactions => "./data/transactions.csv",
                              :invoice_items => "./data/invoice_items.csv",
                              :customers => "./data/customers.csv"
                              })
    sales_analyst = sales_engine.analyst
    expected = sales_analyst.invoice_total(1)
    assert_equal 348956.00, expected
  end
end
