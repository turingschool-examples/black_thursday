require_relative 'test_helper.rb'
require_relative '../lib/salesanalyst'
require_relative '../lib/salesengine'
class SalesAnalystTest < Minitest::Test
  def setup
    {:items=>"./test/data/salesanalystitemsample.csv",:merchants=>"./test/data/merchantreposample.csv",:invoices=>"./test/data/salesanalystinvoicesample.csv"}
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

    assert_equal 1.625, sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)

    assert_equal 1.746424919657298, sa.average_invoices_per_merchant_standard_deviation
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

    assert_equal
  end

end
