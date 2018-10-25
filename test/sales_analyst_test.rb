require_relative 'test_helper'

require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv(
      {#changed
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      }
    )
    @sa = se.analyst
  end

  def test_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal 52, @sa.merchants_with_high_item_count.size
  end

  def test_average_item_price_for_merchant
    assert_equal 14.0, @sa.average_item_price_for_merchant(12334135)
  end

  def test_average_average_price_per_merchant
    assert_equal 350.29, @sa.average_average_price_per_merchant
  end

  def test_golden_items
    assert_equal 5, @sa.golden_items.length
  end

  #Iteration 2
  #
  # def test_average_invoices_per_merchant
  #   assert_equal 10.49, @sa.average_invoices_per_merchant
  # end
  # def test_average_invoices_per_merchant_standard_deviation
  #   assert_equal 3.29, @sa.average_invoices_per_merchant_standard_deviation
  # end
  # def test_top_merchants_by_invoice_count
  # end
  # def test_bottom_merchants_by_invoice_count
  # end
  # def test_top_days_by_invoice_count
  #   ["Sunday", "Saturday"]
  # end
  #
  # def test_invoice_status_pending
  #   assert_equal 29.55, @sa.invoice_status(:pending)
  # end
  # def test_invoice_status_pending
  #   assert_equal 56.95, @sa.invoice_status(:shipped)
  # end
  # def test_invoice_status_pending
  #   assert_equal 13.5, @sa.invoice_status(:returned)
  # end

end
