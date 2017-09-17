require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'


class SalesAnalystTest < Minitest::Test

  attr_reader :sa, :se

  def setup
    @se = SalesEngine.from_csv({items: "./data/items.csv",
                            merchants: "./data/merchants.csv",
                            invoices: "./data/invoices.csv"})
                                merchants: "./data/merchants.csv",
                                invoices: "./test/invoices_fixture.csv"})
                                invoices: "./data/invoices.csv"})
    @sa = SalesAnalyst.new(@se)
  end

  def test_average_items
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_standard_deviation
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_average_average_price_per_merchant
    binding.pry
    assert_equal 5.65, sa.average_average_price_per_merchant

  def test_average_invoices_per_merchant
    assert_equal 0.63, sa.average_invoices_per_merchant
  end

  def test_invoices_standard_deviation
    assert_equal 0.79, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_for_top_merchant_by_invoice
    assert_equal [], sa.top_merchants_by_invoice_count
  end
end
