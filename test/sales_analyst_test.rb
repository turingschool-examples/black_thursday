require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'
require 'csv'


class SalesAnalystTest < Minitest::Test

  attr_reader :se, :sa

  def setup
    @se = SalesEngine.from_csv({items: "./data/items.csv",
                            merchants: "./data/merchants.csv",
                            invoices: "./data/invoices.csv",
                            transactions: "./data/transactions.csv",
                            invoice_items: "./data/invoice_items.csv",
                            customers: "./data/customers.csv"})
    @sa = SalesAnalyst.new(@se)
  end

  def test_average_items
    assert_equal 1.1, sa.average_items_per_merchant
  end

  def test_standard_deviation
    assert_equal 2.25, sa.average_items_per_merchant_standard_deviation
  end

  def test_average_average_price_per_merchant
    skip
    assert_equal 5.65, sa.average_average_price_per_merchant
  end

  def test_average_invoices_per_merchant
    assert_equal 3.02, sa.average_invoices_per_merchant
  end

  def test_invoices_standard_deviation
    assert_equal 3.29, sa.average_invoices_per_merchant_standard_deviation
    binding.pry
  end

  def test_for_top_merchant_by_invoice
    assert_equal [], sa.top_merchants_by_invoice_count
  end

  def test_top_days_by_invoice_count
    assert_equal ["Sunday"], sa.top_days_by_invoice_count
  end

  def test_that_it_returns_all_statuses
    assert_equal 299, sa.status_array.count
  end

  def test_for_invoice_status
    assert_equal 32.44, sa.invoice_status(:pending)
    assert_equal 55.52, sa.invoice_status(:shipped)
    assert_equal 12.04, sa.invoice_status(:returned)
  end
end
