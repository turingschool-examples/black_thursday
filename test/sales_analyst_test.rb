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
                                :invoices => "./test/fixtures/invoices.csv",
                                :customers => "./test/fixtures/customers.csv",
                                :transactions => "./test/fixtures/transactions.csv",
                              :invoice_items => "./test/fixtures/invoice_items.csv"}
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

  def test_average_invoices_per_merchant
    skip
    assert_equal 0.875, @sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    skip
    assert_equal 0.95, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    skip
    assert_equal @se.invoices.find_all_by_merchant_id(12334269), @sa.top_merchants_by_invoice_count
  end

  def test_bottom_merchants_by_invoice_count
    skip
    assert_equal @se.invoices.find_all_by_merchant_id(34444), @sa.bottom_merchants_by_invoice_count
  end

  #parking lot this for tomorrow

  # def test_top_days_by_invoice_count
  #   assert_equal ["Sunday"], @sa.top_days_by_invoice_count
  # end

  def test_the_invoice_status
    skip
    assert_equal 62.5, @sa.invoice_status(:pending)
    assert_equal 25.0, @sa.invoice_status(:shipped)
    assert_equal 12.5, @sa.invoice_status(:returned)
  end

  def test_it_can_check_if_invoice_is_paid_in_full
    assert_equal true, @sa.invoice_paid_in_full?(3374)
  end

  def test_it_can_return_dollar_amount_of_invoices_based_on_id
    assert_equal 21048, @sa.invoice_total(1)
  end

  def test_it_can_give_us_golden_items
    expected = @se.items.find_by_id(2)
    assert_equal [expected], @sa.golden_items
  end

end
