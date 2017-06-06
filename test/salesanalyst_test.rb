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

    assert_equal 1.5 ,sa.average_items_per_merchant
  end

  def test_retrieve_average_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)

    assert_equal 1.0 ,sa.average_items_per_merchant_standard_deviation
  end

  def test_retrieve_merchants_with_high_item_count
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)
    a = sa.merchants_with_high_item_count

    assert_equal 12334185 ,a[0]
  end

  def test_retrieve_average_item_price_for_merchant
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)


    assert_equal 9 ,sa.average_item_price_for_merchant(12334185).to_f
  end

  def test_average_average_price_per_merchant
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)

    assert_equal 4.75, sa.average_average_price_per_merchant.to_f
  end

  def test_retrieve_golden_items
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)
    a = sa.golden_items

    assert_equal "263396013", a[0]
  end

  def test_average_invoices_per_merchant
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)

    assert_equal 1.63, sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)

    assert_equal 1.75, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)
    a = sa.top_merchants_by_invoice_count

    assert_equal 12335009, a[0]
  end

  def test_bottom_merchants_by_invoice_count
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)
    a = sa.bottom_merchants_by_invoice_count

    assert_equal [], a
  end

  def test_top_days_by_invoice_count
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)

    assert_equal ['Friday'], sa.top_days_by_invoice_count
  end

  def test_invoice_status
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)

    assert_equal 38.46, sa.invoice_status(:pending)
    assert_equal 57.69, sa.invoice_status(:shipped)
    assert_equal 3.85, sa.invoice_status(:returned)

  end

end
