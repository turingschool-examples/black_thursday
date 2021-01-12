require_relative './test_helper'
require './lib/sales_analyst'
require './lib/standard_deviation'
require 'bigdecimal/util'
require 'mocha/minitest'

class SalesAnalystTest < Minitest::Test
  include StandardDeviation

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./fixture_data/items_fixtures_file.csv",
      :merchants => "./fixture_data/merchants_sample.csv",
      :invoices  => "./fixture_data/invoices_sample.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./fixture_data/transactions_sample.csv",
      :customers => "./data/customers.csv",
      })
  end

  def test_it_exists_and_has_attributes
    assert_instance_of SalesAnalyst, @se.analyst
  end

  def test_average_items_per_merchant
    assert_equal 2.42, @se.analyst.average_items_per_merchant
  end

  def test_reduce_shop_items
    assert_equal 29, @se.analyst.reduce_shop_items.values.flatten.count
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 2.84, @se.analyst.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal 1, @se.analyst.merchant_names_with_high_item_count.count
    assert_equal Merchant, @se.analyst.merchants_with_high_item_count[0].class
  end

  def test_average_item_price_for_merchant
    assert_equal 29.99, @se.analyst.average_item_price_for_merchant(12334105)
  end

  def test_second_deviation_above_unit_price
    assert_equal 0.54076e3, @se.analyst.second_deviation_above_unit_price
  end

  def test_average_average_price_per_merchant
    expected = 0.674e2
    assert_equal expected.to_d, @se.analyst.average_average_price_per_merchant
  end

  def test_golden_items
    assert_equal Array, @se.analyst.golden_items.class
    assert_equal Item, @se.analyst.golden_items[1].class
    assert_equal 5, @se.analyst.golden_items.count
  end

  def test_average_invoices_per_merchant
    assert_equal 11.42, @se.analyst.average_invoices_per_merchant
    assert_equal Float, @se.analyst.average_invoices_per_merchant.class
  end

  def test_reduce_merchants_and_invoices
    assert_equal 12, @se.analyst.reduce_merchants_and_invoices.keys.count
    assert_equal 12, @se.analyst.reduce_merchants_and_invoices.values.count
    assert_equal Hash, @se.analyst.reduce_merchants_and_invoices.class
  end

  def test_number_of_invoices
    assert_equal Array, @se.analyst.number_of_invoices.class
    assert_equal 12, @se.analyst.number_of_invoices.count
  end

  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 4.19, @se.analyst.average_invoices_per_merchant_standard_deviation
    assert_equal Float, @se.analyst.average_invoices_per_merchant_standard_deviation.class
  end

  def test_second_deviation_above_invoice_count
    assert_equal 19.8, @se.analyst.second_deviation_above_average_invoice_count
    assert_equal Float, @se.analyst.second_deviation_above_average_invoice_count.class
  end

  def test_top_merchants_by_invoice_count
    assert_equal Array, @se.analyst.top_merchants_by_invoice_count.class
  end

  def test_second_deviation_below_average_invoice_count
    assert_equal 3.04, @se.analyst.second_deviation_below_average_invoice_count
    assert_equal Float, @se.analyst.second_deviation_below_average_invoice_count.class
  end

  def test_bottom_merchants_by_invoice_count
    assert_equal Array, @se.analyst.bottom_merchants_by_invoice_count.class
  end

  def test_reduce_invoices_and_days
    assert_equal Hash, @se.analyst.reduce_invoices_and_days.class
    assert_equal 7, @se.analyst.reduce_invoices_and_days.keys.count
  end

  def test_invoices_by_day_count
    assert_equal Array, @se.analyst.invoices_by_day_count.class
    assert_equal 7, @se.analyst.invoices_by_day_count.count
  end

  def test_average_invoices_per_day_standard_deviation
    assert_equal Float, @se.analyst.average_invoices_per_day_standard_deviation.class
    assert_equal 3.26, @se.analyst.average_invoices_per_day_standard_deviation
  end

  def test_average_invoices_per_day
    assert_equal Float, @se.analyst.average_invoices_per_day.class
    assert_equal 19.57, @se.analyst.average_invoices_per_day
  end

  def test_one_deviation_above_invoices_per_day
    assert_equal Float, @se.analyst.one_deviation_above_invoices_per_day.class
    assert_equal 22.83, @se.analyst.one_deviation_above_invoices_per_day
  end

  def test_top_days_by_invoice_count
    assert_equal Array, @se.analyst.top_days_by_invoice_count.class
    assert_equal String, @se.analyst.top_days_by_invoice_count[0].class
  end

  def test_invoice_status
    assert_equal Float, @se.analyst.invoice_status(:pending).class
    assert_equal Float, @se.analyst.invoice_status(:shipped).class
    assert_equal Float, @se.analyst.invoice_status(:returned).class

    expected = @se.analyst.invoice_status(:pending)
    expected += @se.analyst.invoice_status(:shipped)
    expected += @se.analyst.invoice_status(:returned)

    assert_equal expected, 100
  end

  def test_merchants_with_pending_invoices
    assert_equal Array, @se.analyst.merchants_with_pending_invoices.class
    assert_equal 12, @se.analyst.merchants_with_pending_invoices.count
    assert_equal Merchant, @se.analyst.merchants_with_pending_invoices[0].class
  end

  def test_merchants_with_only_one_item
    assert_equal Array, @se.analyst.merchants_with_only_one_item.class
    assert_equal 7, @se.analyst.merchants_with_only_one_item.count
    assert_equal Merchant, @se.analyst.merchants_with_only_one_item[0].class
  end

  def test_merchants_with_only_one_item_registered_in_month
    assert_equal Array, @se.analyst.merchants_with_only_one_item_registered_in_month("January").class
    assert_equal 7, @se.analyst.merchants_with_only_one_item_registered_in_month("January").count
    assert_equal Merchant, @se.analyst.merchants_with_only_one_item_registered_in_month("January")[0].class
  end

  def test_find_the_total_revenue_for_a_single_merchant
    repo = mock
    transaction = Transaction.new({
                  :id => 6,
                  :invoice_id => 8,
                  :credit_card_number => "4242424242424242",
                  :credit_card_expiration_date => "0220",
                  :result => "success",
                  :created_at => Time.now
                  }, repo)

    assert_equal nil, @se.analyst.transaction_to_invoice(transaction)
    # assert_equal nil, @se.analyst.transaction_dollar_value(transaction)
    assert_equal 0.260395e5, @se.analyst.revenue_by_merchant(12334105)
    assert_equal BigDecimal, @se.analyst.revenue_by_merchant(12334105).class
  end
end
