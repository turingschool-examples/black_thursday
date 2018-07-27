require_relative 'test_helper'
require_relative '../lib/sales_analyst.rb'
require_relative '../lib/sales_engine.rb'

class SalesAnalystTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.from_csv({
                        :items     => "./data/items.csv",
                        :merchants => "./data/merchants.csv",
                        :invoices => "./data/invoices.csv",
                        :invoice_items => "./data/invoice_items.csv",
                        :transactions => "./data/transactions.csv",
                        :customers => "./data/customers.csv"
                      })
    @sales_analyst = @sales_engine.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_can_average_items_per_merchant
    expected = 2.88
    actual = @sales_analyst.average_items_per_merchant

    assert_equal expected, actual
  end

  def test_it_can_find_stddev_of_average_items_per_merchant
    expected = 3.26
    actual = @sales_analyst.average_items_per_merchant_standard_deviation

    assert_equal expected, actual
  end

  def test_which_merchants_exceed_1_stdev_higher_than_average_number_products
    expected = 52
    actual = @sales_analyst.merchants_with_high_item_count.count

    assert_equal expected, actual
  end

  def test_it_can_find_average_item_price_for_merchant
    expected = 16.66
    actual = @sales_analyst.average_item_price_for_merchant(12334105)

    assert_equal expected, actual
  end

  def test_it_can_find_average_average_price_for_merchant
    expected = 350.29
    actual = @sales_analyst.average_average_price_per_merchant

    assert_equal expected, actual
  end

  def test_it_can_find_golden_items
    expected = 5
    actual = @sales_analyst.golden_items.count

    assert_equal expected, actual
  end

  def test_it_can_find_average_invoices_per_merchant
    expected = 10.49
    actual = @sales_analyst.average_invoices_per_merchant

    assert_equal expected, actual
  end

  def test_it_can_find_stddev_of_average_items_per_merchant
    expected = 3.29
    actual = @sales_analyst.average_invoices_per_merchant_standard_deviation

    assert_equal expected, actual
  end

  def test_it_can_find_top_merchants_by_invoice_count
    expected = 12
    actual = @sales_analyst.top_merchants_by_invoice_count

    assert_instance_of Merchant, actual[0]
    assert_equal expected, actual.count
  end

  def test_it_can_find_bottom_merchants_by_invoice_count
    expected = 4
    actual = @sales_analyst.bottom_merchants_by_invoice_count

    assert_instance_of Merchant, actual[0]
    assert_equal expected, actual.count
  end

  def test_it_can_find_top_days_by_invoice_count
    expected = ["Wednesday"]
    actual = @sales_analyst.top_days_by_invoice_count
    assert_equal expected, actual
  end

  def test_it_can_show_invoice_status_percentage
    expected = 29.55
    actual = @sales_analyst.invoice_status(:pending)

    assert_equal expected, actual

    expected_2 = 56.95
    actual_2 = @sales_analyst.invoice_status(:shipped)

    assert_equal expected_2, actual_2

    expected_3 = 13.5
    actual_3 = @sales_analyst.invoice_status(:returned)

    assert_equal expected_3, actual_3
  end
end
