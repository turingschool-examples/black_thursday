require_relative 'test_helper'

require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv'
    })
    @sa = se.analyst
  end

  def test_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    skip
    assert_equal 52, @sa.merchants_with_high_item_count
  end

  def test_average_item_price_for_merchant
    skip
    assert_equal 16.66, average_item_price_for_merchant(merchant_id)
  end

  def test_average_average_price_per_merchant
    skip
    assert_equal 350.29, @sa.average_price_per_merchant
  end

  def test_golden_items
    skip
    assert_equal 5, @sa.golden_items.length
  end

  def test_it_finds_percentage_of_invoices_status_returned
    assert_equal 13.5, @sa.invoice_status(:returned)
  end

  def test_it_finds_percentage_of_invoices_status_pending
    assert_equal 29.55, @sa.invoice_status(:pending)
  end

  def test_it_finds_percentage_of_invoices_status_shipped
    assert_equal 56.95, @sa.invoice_status(:shipped)
  end
end
