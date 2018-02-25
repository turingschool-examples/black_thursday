require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup
    @data = {
      :items          => "./test/fixtures/items_sample.csv",
      :merchants      => "./test/fixtures/merchants_sample.csv",
      :invoices       => "./test/fixtures/invoices_sample.csv",
      :invoice_items  => "./test/fixtures/invoice_items_sample.csv",
      :transactions   => "./test/fixtures/transactions_sample.csv",
      :customers      => "./test/fixtures/customers_sample.csv"
        }
    @se = SalesEngine.new(@data)
    @sales_analyst = SalesAnalyst.new(@se)
  end

  def test_average_items_per_merchant
    assert_equal 2.63, @sales_analyst.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 3.16, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_item_count_per_merchant
    expected = [1, 3, 1, 10, 2, 3, 1, 0]

    assert_equal expected, @sales_analyst.items_count_per_merchant
  end

  def test_merchants_with_high_item_count
    expected = [@se.find_merchant_by_merchant_id(12334195)]

    assert_equal expected, @sales_analyst.merchants_with_high_item_count
  end

  def test_avg_item_price_for_merchant
    assert_equal 0.1117e2, @sales_analyst.average_item_price_for_merchant(12334185)
  end

  def test_avg_avg_price_for_merchant
    assert_equal 0.13847e3, @sales_analyst.average_average_price_per_merchant
  end

  def test_golden_items
    golden = @sales_analyst.golden_items.map { |item| item.id }
    expected = []

    assert_equal expected, golden
  end

  def test_average_invoices_per_merchant
    assert_equal 2.0, @sales_analyst.average_invoices_per_merchant
  end

  def test_invoice_count_per_merchant
    expected = [9, 2, 1, 1, 1, 1, 1, 0]

    assert_equal expected, @sales_analyst.invoice_count_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 2.88, @sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    merchants = @sales_analyst.top_merchants_by_invoice_count

    assert_equal [@se.find_merchant_by_merchant_id(12334141)], merchants
  end

  def test_bottom_merchants_by_invoice_count
    merchants = @sales_analyst.bottom_merchants_by_invoice_count

    assert_equal [], merchants
  end

  def test_top_days_by_invoice_count
    top = @sales_analyst.top_days_by_invoice_count

    assert_equal ["Tuesday", "Friday"], top
  end

  def test_invoice_days
    expected = { "Monday"=>1, "Tuesday"=>6, "Wednesday"=>2, "Thursday"=>2,
                 "Friday"=>7, "Saturday"=>1, "Sunday"=>1 }
                 
    assert_equal expected, @sales_analyst.invoice_days
  end

  def test_invoice_status
    pending = @sales_analyst.invoice_status(:pending)
    shipped = @sales_analyst.invoice_status(:shipped)
    returned =  @sales_analyst.invoice_status(:returned)

    assert_equal 15.00, pending
    assert_equal 65.00, shipped
    assert_equal 20.00,returned
  end

end
