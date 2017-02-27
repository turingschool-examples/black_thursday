require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa, :se
  def setup
    @se = SalesEngine.from_csv({
      :items => "./test/fixtures/item_fixture.csv",
      :merchants => "./test/fixtures/merchant_fixture.csv",
      :invoices => "./test/fixtures/invoice_fixture.csv",
      :invoice_items => "./test/fixtures/invoice_items_fixture.csv",
      :transactions => "./test/fixtures/transaction_fixture.csv",
      :customers => "./test/fixtures/customer_fixture.csv",
      })
    @sa = SalesAnalyst.new(se)
  end

  # def setup
  #   @se = SalesEngine.from_csv({
  #     :items => "./data/items.csv",
  #     :merchants => "./data/merchants.csv",
  #     :invoices => "./data/invoices.csv"
  #     })
  #   @sa = SalesAnalyst.new(se)
  # end

  def test_average_items_per_merchant
    assert_equal 1.88, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 1.88, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal 4, sa.merchants_with_high_item_count.count
    assert_instance_of Merchant, sa.merchants_with_high_item_count.first
  end

  def test_average_item_price_for_merchant
    assert_equal (BigDecimal.new(5050)/100), sa.average_item_price_for_merchant(12334365)
  end

  def test_average_average_price_per_merchant
    assert_equal (BigDecimal.new(15525)/100), sa.average_average_price_per_merchant
  end

  def test_average_item_price
    assert_equal (BigDecimal.new(16686)/100), sa.average_item_price
  end

  def test_average_item_price_standard_deviation
    assert_equal 376.88, sa.average_item_price_standard_deviation
  end

  def test_golden_items
    assert_equal 1, sa.golden_items.length
    assert_instance_of Item, sa.golden_items.first
  end

  def test_average_invoices_per_merchant
    assert_equal 11.0, sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 3.63, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    assert_equal 0, sa.top_merchants_by_invoice_count.count
  end

  def test_bottom_merchants_by_invoice_count
    assert_equal 1, sa.bottom_merchants_by_invoice_count.count
    assert_instance_of Merchant, sa.bottom_merchants_by_invoice_count.first
  end

  def test_top_days_by_invoice_count
    assert_equal ['Friday'], sa.top_days_by_invoice_count
  end

  def test_invoice_status
    assert_equal 29.18, sa.invoice_status(:pending)
    assert_equal 55.6, sa.invoice_status(:shipped)
    assert_equal 15.22, sa.invoice_status(:returned)
  end


  def test_total_revenue_by_date
    date = Time.parse("2009-02-07")
    assert_equal 1, sa.total_revenue_by_date(date).count
  end
end
