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

  def test_it_can_check_if_invoice_is_paid_in_full
    assert_equal true, @sa.invoice_paid_in_full?(3374)
  end

  def test_it_can_return_dollar_amount_of_invoices_based_on_id
    assert_equal 21048, @sa.invoice_total(1)
  end

end
