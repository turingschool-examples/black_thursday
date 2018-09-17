require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'pry'

class SalesAnalystTest<Minitest::Test

  def setup
    @se = SalesEngine.from_csv(
                               {:items => "./test/fixtures/items.csv",
                                :merchants => "./test/fixtures/merchants.csv",
                                :invoices => "./test/fixtures/invoices.csv"}
                            )
    @sa = @se.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_gives_average_items_per_merchant
    assert_equal 0.875, @sa.average_items_per_merchant
  end

  def test_it_can_give_average_items_per_merchant_standard_deviation
    assert_equal 0.48, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_calculates_merchants_with_high_item_count
    expected = [@se.merchants.find_by_id(1)]
    assert_equal expected, @sa.merchants_with_high_item_count
  end

  def test_it_can_do_average_average_price_per_merchant
    assert_equal 148005.43, @sa.average_average_price_per_merchant
  end

  def test_average_invoices_per_merchant_aaa
    assert_equal 0.875, @sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 0.95, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    assert_equal @se.invoices.find_all_by_merchant_id(12334269), @sa.top_merchants_by_invoice_count
  end

  def test_bottom_merchants_by_invoice_count
    assert_equal @se.invoices.find_all_by_merchant_id(34444), @sa.bottom_merchants_by_invoice_count
  end

  #parking lot this for tomorrow

  # def test_top_days_by_invoice_count
  #   assert_equal ["Sunday"], @sa.top_days_by_invoice_count
  # end

  def test_the_invoice_status
    assert_equal 62.5, @sa.invoice_status(:pending)
    assert_equal 25.0, @sa.invoice_status(:shipped)
    assert_equal 12.5, @sa.invoice_status(:returned)
  end

end
