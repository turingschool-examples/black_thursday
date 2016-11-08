require_relative 'test_helper'
require_relative '../lib/merchants_revenue_analyst'

class MerchantsRevenueAnalystTest < Minitest::Test

  attr_reader :engine, :analyst

  def setup 
    @engine = SalesEngine.from_csv({:items => './test/assets/test_items.csv', 
                                    :merchants => './test/assets/test_merchants.csv', 
                                    :invoices => "./test/assets/test_invoices.csv", 
                                    :invoice_items => "./test/assets/test_invoice_items.csv",
                                    :transactions => "./test/assets/test_transactions.csv",
                                    :customers => "./test/assets/test_customers.csv"})
    @analyst = MerchantsRevenueAnalyst.new(engine)
  end

  def test_total_revnue_by_date_in_analyst_class
    assert_equal 6444.38, analyst.total_revenue_by_date(Time.parse("2012-03-27")).to_f
  end

  def test_find_top_revenue_merchants_in_analyst_class
    expected = 55
    result = analyst.top_revenue_earners(4).map {|merchant| merchant.id}
    assert_equal 4, result.count
    assert_equal expected, result.first
  end

  def test_find_top_merchants_returns_twenty_merchants_by_default_in_analyst_class
    assert_equal 20, analyst.top_revenue_earners.count
  end

  def test_it_finds_revenue_for_single_merchant_in_analyst_class
    assert_equal 34365.66, analyst.revenue_by_merchant(55).to_f
  end

  def test_merchants_ranked_by_revenue_returns_all_ranked_merchants_in_analyst_class
    result = analyst.merchants_ranked_by_revenue
    assert_equal 27, result.count
    assert_equal 55, result.first.id
    assert_equal 9, result.last.id
  end

end