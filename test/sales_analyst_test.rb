require './test/test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'
require 'pry'

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     => './mock_data/items_test.csv',
      :merchants => './mock_data/merchants_test.csv',
      :invoices => './mock_data/invoices_test.csv',
      :invoice_items => './mock_data/invoice_items_test.csv',
      :transactions => './mock_data/transactions_test.csv',
      :customers => './mock_data/customers_test.csv'
      })
    @sa = SalesAnalyst.new(@se)
  end

  def test_it_exists
    skip
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_can_create_an_instance_of_sales_engine
    skip
    assert_instance_of SalesEngine, @sa.se
  end

  def test_it_can_group_items_by_merchant
    skip
    result = @sa.group_items_by_merchant
    assert_equal 475, result.length
    assert_equal 6, result[12334185].length
  end

  def test_it_can_return_items_per_merchant
    skip
    result = @sa.items_per_merchant
    assert_equal 475, result.length
    assert_equal 1, result[0]
  end

  def test_it_can_count_items_per_merchant
    skip
    assert_equal 6, @sa.items_per_merchant[1]
  end

  def test_it_can_find_the_average_number_of_items_per_merchant
    skip
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_it_can_find_average_items_per_merchant_standard_deviation
    skip
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_find_merchants_with_high_item_count
    skip
    assert_equal 52, @sa.merchants_with_high_item_count.length
    assert_instance_of Merchant, @sa.merchants_with_high_item_count[0]
    assert_instance_of Merchant, @sa.merchants_with_high_item_count[-1]
  end

  def test_it_can_select_merchant_ids_over_standard_deviation
    skip
    assert_equal 52, @sa.select_merchant_ids_over_standard_deviation.length
    assert_instance_of Fixnum, @sa.select_merchant_ids_over_standard_deviation[-1]
    assert_instance_of Fixnum, @sa.select_merchant_ids_over_standard_deviation[0]
  end

  def test_it_can_find_average_item_price_for_merchant
    skip
    assert_equal 10.78, @sa.average_item_price_for_merchant(12334185)
    assert_instance_of BigDecimal, @sa.average_item_price_for_merchant(12334185)
  end

  def test_it_can_find_average_average_price_per_merchant
    skip
    assert_instance_of BigDecimal, @sa.average_average_price_per_merchant
    assert_equal 350.29, @sa.average_average_price_per_merchant
  end

  def test_it_can_find_average_item_price
    skip
    assert_equal 251.06, @sa.average_item_price
  end

  def test_it_can_calculate_standard_deviation_for_prices
    skip
    assert_instance_of BigDecimal, @sa.average_price_standard_deviation
    assert_equal 251.06, @sa.average_item_price
  end

  def test_it_can_find_golden_items
    skip
    assert_equal 5, @sa.golden_items.length
  end

  def test_it_can_group_invoices_by_merchant
    # skip
    assert_equal 15, @sa.group_invoices_by_merchant[2].count
    assert_equal 9, @sa.group_invoices_by_merchant[5].count
  end

  def test_it_can_find_total_number_of_invoices
    skip
    assert_equal 63, @sa.total_invoices
  end

  def test_it_can_find_the_number_of_merchants_for_invoice
    skip
    assert_equal 5, @sa.total_merchants_by_invoice
  end

  def test_it_can_return_average_invoices_per_merchant
    # skip
    assert_equal 9.25, @sa.average_invoices_per_merchant
  end

  def test_it_can_find_standard_deviation_of_avg_invoices_per_merchant
    skip
    assert_equal 3.29
  end
end
