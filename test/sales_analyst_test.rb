require './test/test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def setup
    repositories = {
      items: './data/sample_data/items.csv',
      merchants: './data/sample_data/merchants.csv',
      invoices: './data/sample_data/invoices.csv',
      transactions: './data/sample_data/transactions.csv',
      customers: './data/sample_data/customers.csv',
      invoice_items: './data/sample_data/invoice_items.csv'
    }
    sales_eng = SalesEngine.new(repositories)
    @sa       = SalesAnalyst.new(sales_eng)
  end

  def test_sales_analyst_class_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_average_items_per_merchant
    assert_equal 2.5, @sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    actual = @sa.average_items_per_merchant_standard_deviation
    assert_equal 2.65, actual
  end

  def test_merchants_with_high_item_count
    actual = @sa.merchants_with_high_item_count.first.name
    assert_equal 'MiniatureBikez', actual
  end

  def test_average_item_price_for_merchant
    actual = @sa.average_item_price_for_merchant(123_341_05)
    assert_equal 0.1166e2, actual
  end

  def test_average_average_price_per_merchant
    actual = @sa.average_average_price_per_merchant
    assert_equal 60.66, actual
  end

  def test_golden_items
    golden_items = @sa.golden_items
    assert_equal 'Some stuff', golden_items.first.name
  end

  def test_it_finds_invoices_for_each_merchant
    assert_equal [2.0, 0.0, 0.0, 1.0], @sa.invoices_for_each_merchant
  end

  def test_average_invoices_per_merchant
    actual = @sa.average_invoices_per_merchant
    assert_equal 0.75, actual
  end

  def test_average_invoices_per_merchant_standard_deviation
    actual = @sa.average_invoices_per_merchant_standard_deviation
    assert_equal 0.96, actual
  end

  def test_top_merchants_by_index_count
    actual = @sa.top_merchants_by_invoice_count
    assert_equal 1, actual
  end

end
