require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

# Test for the SalesAnalyst class
class SalesAnalystTest < Minitest::Test
  def setup
    sales_engine = SalesEngine.from_csv(
      invoices: './test/fixtures/test_invoices.csv',
      items: './test/fixtures/test_items1.csv',
      merchants: './test/fixtures/test_merchants1.csv'
    )
    @sales_analyst = SalesAnalyst.new(sales_engine)
  end

  def test_sales_analyst_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_average_items_per_merchant
    assert_equal 2.80, @sales_analyst.average_items_per_merchant
    assert_instance_of Float, @sales_analyst.average_items_per_merchant
  end

  def test_average_items_per_merchant_std_dev
    result = @sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal 2.49, result
    assert_instance_of Float, result
  end

  def test_items_per_merchant
    expected = { 12334185 => 3,
                 12334213 => 2,
                 12334195 => 7,
                 12334315 => 1,
                 12334499 => 1 }
    assert_equal expected, @sales_analyst.items_per_merchant
  end

  def test_merchants_with_high_item_count
    result = @sales_analyst.merchants_with_high_item_count
    assert_instance_of Merchant, result[0]
    assert_equal ['FlavienCouche'], result.map(&:name)
  end

  def test_average_item_price_for_merchant
    result = @sales_analyst.average_item_price_for_merchant(12334185)
    assert_instance_of BigDecimal, result
    assert_equal 11.17, result.to_f.round(2)
  end

  def test_average_average_price_per_merchant
    result = @sales_analyst.average_average_price_per_merchant
    assert_instance_of BigDecimal, result
    assert_equal 20092.68, result.to_f.round(2)
  end

  def test_average_item_price
    assert_equal 7357.66, @sales_analyst.average_item_price.to_f.round(2)
  end

  def test_average_item_price_standard_deviation
    result = @sales_analyst.average_item_price_standard_deviation
    assert_equal 26665.15, result
    assert_instance_of Float, result
  end

  def test_golden_items
    result = @sales_analyst.golden_items
    assert_equal ['Test listing'], result.map(&:name)
    assert_instance_of Item, result[0]
  end

  def test_average_invoices_per_merchant
    sales_engine = SalesEngine.from_csv(
      invoices: './test/fixtures/test_invoices2.csv',
      items: './test/fixtures/test_items1.csv',
      merchants: './test/fixtures/test_merchants2.csv'
    )
    sales_analyst = sales_engine.analyst
    assert_equal 1.25, sales_analyst.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    sales_engine = SalesEngine.from_csv(
      invoices: './test/fixtures/test_invoices2.csv',
      items: './test/fixtures/test_items1.csv',
      merchants: './test/fixtures/test_merchants2.csv'
    )
    sales_analyst = sales_engine.analyst
    assert_equal 1.46, sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_getting_invoice_count
    sales_engine = SalesEngine.from_csv(
      invoices: './test/fixtures/test_invoices2.csv',
      items: './test/fixtures/test_items1.csv',
      merchants: './test/fixtures/test_merchants2.csv'
    )
    sales_analyst = sales_engine.analyst
    assert_equal 2, sales_analyst.invoice_count(12334264)
  end

  def test_top_merchants
    sales_engine = SalesEngine.from_csv(
      invoices: './test/fixtures/test_invoices2_b.csv',
      items: './test/fixtures/test_items1.csv',
      merchants: './test/fixtures/test_merchants2.csv'
    )
    sales_analyst = sales_engine.analyst
    result = sales_analyst.top_merchant_by_invoice_count
    assert_instance_of Merchant, result[0]
    assert_equal [12334873], result.map(&:id)
    
  end
end
