require_relative 'test_helper'
require 'bigdecimal'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({
      items: './test/data/test_items.csv',
      merchants: './test/data/test_merchants.csv',
      invoices: './test/data/test_invoices.csv',
      invoice_items: './test/data/test_invoice_items.csv'

    })
    @sa = se.analyst
  end


    def test_average_items_per_merchant
      assert_equal 4.86, @sa.average_items_per_merchant
    end

    def test_average_items_per_merchant_standard_deviation
      assert_equal 6.91, @sa.average_items_per_merchant_standard_deviation
    end

    def test_merchants_with_high_item_count
      assert_equal 1, @sa.merchants_with_high_item_count.size
    end

    def test_average_item_price_for_merchant
      assert_equal 0.11, @sa.average_item_price_for_merchant(12334185)
    end

    def test_average_average_price_per_merchant
      assert_equal 42857.98, @sa.average_average_price_per_merchant
    end

    def test_golden_items
      assert_equal 1, @sa.golden_items.length
    end

    def test_it_finds_percentage_of_invoices_status_returned
      assert_equal 19.18, @sa.invoice_status(:returned)
    end

    def test_it_finds_percentage_of_invoices_status_pending
      assert_equal 39.73, @sa.invoice_status(:pending)
    end

    def test_it_finds_percentage_of_invoices_status_shipped
      assert_equal 41.1, @sa.invoice_status(:shipped)
    end

    def test_average_invoices_per_merchant
      assert_equal 10.43, @sa.average_invoices_per_merchant
    end
    def test_average_invoices_per_merchant_standard_deviation
      assert_equal 4.79, @sa.average_invoices_per_merchant_standard_deviation
    end
    def test_top_merchants_by_invoice_count
      assert_equal 0, @sa.top_merchants_by_invoice_count.size
    end
    def test_bottom_merchants_by_invoice_count
      assert_equal 0, @sa.bottom_merchants_by_invoice_count.size
    end
    def test_top_days_by_invoice_count
      assert_equal [], @sa.top_days_by_invoice_count
    end
  #
  # def test_total_revenue_by_date
  #   assert_equal 109080, @sa.total_revenue_by_date(Time.parse("2000-04-26"))
  # end
end
