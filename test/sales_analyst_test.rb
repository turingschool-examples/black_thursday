require_relative 'test_helper'

require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
      items: '.test/data/test_items.csv',
      merchants: '.test/data/test_merchants.csv',
      invoices: '.test/data/invoices.csv'
    })
    @sa = se.analyst
  end

  def test_average_items_per_merchant
    assert_equal 0.03, @sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 0.95, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal 7, @sa.merchants_with_high_item_count.size
  end

  def test_average_item_price_for_merchant

    assert_equal 14.0, @sa.average_item_price_for_merchant(12334135)
  end

  def test_average_average_price_per_merchant
    skip
    assert_equal 350.29, @sa.average_average_price_per_merchant
  end

  def test_golden_items
    assert_equal 1, @sa.golden_items.length
  end

  def test_it_finds_percentage_of_invoices_status_returned
    assert_equal 7.69, @sa.invoice_status(:returned)
  end

  def test_it_finds_percentage_of_invoices_status_pending
    assert_equal 23.08, @sa.invoice_status(:pending)
  end

  def test_it_finds_percentage_of_invoices_status_shipped
    assert_equal 69.23, @sa.invoice_status(:shipped)
  end

  def test_average_invoices_per_merchant
    assert_equal 0.03, @sa.average_invoices_per_merchant
  end
  def test_average_invoices_per_merchant_standard_deviation
    skip
    assert_equal 3.29, @sa.average_invoices_per_merchant_standard_deviation
  end
  def test_top_merchants_by_invoice_count
    skip
    assert_equal 12, @sa.top_merchants_by_invoice_count.size
  end
  def test_bottom_merchants_by_invoice_count
    skip
    assert_equal 4, @sa.bottom_merchants_by_invoice_count.size
  end
  def test_top_days_by_invoice_count
    assert_equal ["Monday", "Wednesday"], @sa.top_days_by_invoice_count
  end
end
