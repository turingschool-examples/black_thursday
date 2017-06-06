require_relative 'test_helper.rb'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
class SalesAnalystTest < Minitest::Test
  def setup
    {:items=>"./data/items.csv",:merchants => "./data/merchants.csv",:invoices =>"./data/invoices.csv",:invoice_items=>"./data/invoice_items.csv",:transactions=>"./data/transactions.csv",:customers=>"./data/customers.csv"}
  end

  def test_it_exists
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)

    assert_instance_of SalesAnalyst, sa
  end

  def test_retrieve_average_items_per_merchant
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)

    assert_equal 2.88 ,sa.average_items_per_merchant
  end

  def test_retrieve_average_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)

    assert_equal 3.26 ,sa.average_items_per_merchant_standard_deviation
  end

  def test_retrieve_merchants_with_high_item_count
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)
    a = sa.merchants_with_high_item_count

    assert_equal "FlavienCouche" ,a[0].name
  end

  def test_retrieve_average_item_price_for_merchant
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)


    assert_equal 10.78 ,sa.average_item_price_for_merchant(12334185).to_f
  end

  def test_average_average_price_per_merchant
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)

    assert_equal 350.29, sa.average_average_price_per_merchant.to_f
  end

  def test_retrieve_golden_items
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)
    a = sa.golden_items

    assert_equal "Test listing", a[0].name
  end

  def test_average_invoices_per_merchant
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)

    assert_equal 10.49, sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)

    assert_equal 3.29, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)
    a = sa.top_merchants_by_invoice_count

    assert_equal "Chemisonodimenticato", a[0].name
  end

  def test_bottom_merchants_by_invoice_count
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)
    a = sa.bottom_merchants_by_invoice_count

    assert_equal "WellnessNeelsen", a[0].name
  end

  def test_top_days_by_invoice_count
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)

    assert_equal ['Wednesday'], sa.top_days_by_invoice_count
  end

  def test_invoice_status
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)

    assert_equal 29.55, sa.invoice_status(:pending)
    assert_equal 56.95, sa.invoice_status(:shipped)
    assert_equal 13.5, sa.invoice_status(:returned)
  end

  def test_total_revenue_by_date
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)


    assert_equal 818.1,sa.total_revenue_by_date("2009-04-22")
  end

  def test_top_revenue_earners
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)

    assert_equal nil, sa.top_revenue_earners(x)
  end
end
