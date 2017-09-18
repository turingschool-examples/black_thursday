require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'


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
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_standard_deviation
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_average_average_price_per_merchant
    assert_equal 5.65, sa.average_average_price_per_merchant
  end
  def test_average_invoices_per_merchant
    assert_equal 10.49, sa.average_invoices_per_merchant
  end

  def test_invoices_standard_deviation
    assert_equal 3.29, sa.average_invoices_per_merchant_standard_deviation
    binding.pry
  end

  def test_for_top_merchant_by_invoice
    assert_equal [], sa.top_merchants_by_invoice_count
  end

  def test_golden_items_method
    assert_equal 350, sa.golden_items
  end
end
