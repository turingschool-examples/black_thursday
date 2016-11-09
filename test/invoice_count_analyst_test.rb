require_relative 'test_helper'
require_relative '../lib/invoice_count_analyst'

class InvoiceCountAnalystTest < Minitest::Test

  attr_reader :engine, :analyst

  def setup 
    @engine = SalesEngine.from_csv({:items => './test/assets/test_items.csv', 
                                    :merchants => './test/assets/test_merchants.csv', 
                                    :invoices => "./test/assets/test_invoices.csv", 
                                    :invoice_items => "./test/assets/test_invoice_items.csv",
                                    :transactions => "./test/assets/test_transactions.csv",
                                    :customers => "./test/assets/test_customers.csv"})
    @analyst = InvoiceCountAnalyst.new(engine)
  end

  def test_analyst_finds_average_invoices_per_merchant_in_analyst_class
    assert_equal 1.65, analyst.average_invoices_per_merchant
  end

  def test_it_finds_stdev_of_average_invoices_per_merchant_in_analyst_class
    assert_equal 1.18, analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_analyst_returns_top_performing_merchants_two_stdevs_over_average_in_analyst_class
    top_merchants = ["GeorgiaFayeDesigns"]
    found_merchants = analyst.top_merchants_by_invoice_count
    assert_equal top_merchants, found_merchants.map {|merchant| merchant.name}
  end

  def test_analyst_returns_bottom_performing_merchants_two_stdevs_under_average_in_analyst_class
    lowest_merchants = []
    found_merchants = analyst.bottom_merchants_by_invoice_count
    assert_equal lowest_merchants, found_merchants.map {|merchant| merchant.name}
  end

  def test_invoice_status_returns_percentage_with_status_in_analyst_class
    assert_equal 41.07, analyst.invoice_status(:pending)
  end

  def test_returning_merchants_with_pending_invoices_in_analyst_class
    assert_equal 10, analyst.merchants_with_pending_invoices.count
  end

end