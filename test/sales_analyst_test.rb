require_relative 'test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      transactions: './data/transactions.csv',
      invoice_items: './data/invoice_items.csv',
      customers: './data/customers.csv'
    })
    @sa = @sales_engine.analyst
  end

  # def test_it_exists
  #   assert_instance_of SalesAnalyst, @sa
  # end
  #
  # def test_mean_calculation
  #   assert_equal 5.25, @sa.mean([4, 6, 5, 6])
  # end
  #
  # def test_summed_variance_calculation
  #   assert_equal 5.0, @sa.summed_variance([4, 5, 6, 7])
  # end
  #
  # def test_standard_deviation_calculation
  #   assert_equal 2.3, @sa.standard_deviation([4, 5, 6, 7, 10])
  # end
  #
  # def test_average_items_per_merchant
  #   assert_equal 2.88, @sa.average_items_per_merchant
  # end
  #
  # def test_average_items_per_merchant_standard_deviation
  #   actual = @sa.average_items_per_merchant_standard_deviation
  #   assert_equal 3.26, actual
  # end
  #
  # def test_merchants_with_high_item_count
  #   assert_equal 52, @sa.merchants_with_high_item_count.count
  # end
  #
  # def test_calculates_average_item_price_for_merchant
  #   actual = @sa.average_item_price_for_merchant(12334783)
  #   assert_equal BigDecimal(47.5, 3), actual
  # end
  #
  # def test_calculate_average_average_item_price_for_merchant
  #   actual = @sa.average_average_price_per_merchant
  #   assert_equal 350.29, actual
  # end
  #
  # def test_it_can_group_items_by_merchant_id
  #   assert @sa.items_group_by_merchant_id.all? do |k, v|
  #     Fixnum == k.class && Item == v.class
  #   end
  # end
  #
  # def test_all_item_unit_prices
  #   assert_instance_of Array, @sa.all_item_unit_prices
  #   assert_equal 1367, @sa.all_item_unit_prices.count
  # end
  #
  # def test_average_item_unit_price
  #   assert_equal 251.06, @sa.average_item_unit_price
  # end
  #
  # def test_average_item_unit_price_per_standard_deviation
  #   actual = @sa.average_item_unit_price_standard_deviation
  #   assert_equal 2900.99, actual
  # end
  #
  # def test_golden_items
  #   assert_equal 5, @sa.golden_items.count
  # end
  #
  # def test_invoices_group_by_merchant_id
  #   assert @sa.invoices_group_by_merchant_id.all? do |key, value|
  #     Fixnum == key.class && Invoice == value.class
  #   end
  # end
  #
  # def test_it_can_count_invoices_for_each_merchant_id
  #   actual = @sa.invoice_count_for_each_merchant_id[12_334_753]
  #   assert_equal 15, actual
  # end
  #
  # def test_it_can_calculate_average_invoices_per_merchant
  #   assert_equal 10.49, @sa.average_invoices_per_merchant
  # end
  #
  # def test_average_invoices_per_merchant_standard_deviation
  #   actual = @sa.average_invoices_per_merchant_standard_deviation
  #   assert_equal 3.29, actual
  # end
  #
  # def test_it_can_determine_top_merchants_by_invoice_count
  #   assert_equal 12, @sa.top_merchants_by_invoice_count.count
  # end
  #
  # def test_it_can_determine_top_merchants_by_invoice_count
  #   assert_equal 463, @sa.bottom_merchants_by_invoice_count.count
  # end
  #
  # def test_it_can_group_by_day
  #   assert_equal 7, @sa.invoices_group_by_day.keys.count
  # end
  #
  # def test_invoice_count_by_weekday
  #   assert_equal 7, @sa.invoice_count_by_weekday.keys.count
  # end
  #
  # def test_average_invoice_count_per_weekday
  #   assert_equal 712.14, @sa.average_invoice_count_per_weekday
  # end
  #
  # def test_average_invoice_count_per_weekday_standard_deviation
  #   actual = @sa.average_invoice_count_per_weekday_standard_deviation
  #   assert_equal 18.07, actual
  # end
  #
  # def test_top_days_by_invoice_count
  #   assert_equal ['Wednesday'], @sa.top_days_by_invoice_count
  # end
  #
  # def test_invoice_count_by_status
  #   expected = {:pending=>29.55, :shipped=>56.95, :returned=>13.5}
  #   assert_equal expected, @sa.invoice_count_by_status
  # end
  #
  # def test_invoice_status
  #   assert_equal 29.55, @sa.invoice_status(:pending)
  #   assert_equal 56.95, @sa.invoice_status(:shipped)
  #   assert_equal 13.5, @sa.invoice_status(:returned)
  # end
  #
  # def test_it_can_group_transactions_by_invoice_id
  #   assert @sa.transactions_group_by_invoice_id.all? do |k,v|
  #     k == v[0].id
  #   end
  # end
  #
  # def test_invoice_paid_in_full?
  #   assert @sa.invoice_paid_in_full?(8)
  #   refute @sa.invoice_paid_in_full?(105)
  # end
  #
  # def test_it_can_group_invoice_items_by_invoice
  #   assert @sa.invoice_items_group_by_invoice.all? do |k, v|
  #     k == v[0].id
  #   end
  # end
  #
  # def test_it_can_return_the_total_dollars_for_given_invoice_id
  #   assert_equal 21_067.77 , @sa.invoice_total(1)
  #   # assert_instance_of BigDecimal, @sa.invoice_total(1)
  # end
  #
  # def test_it_can_group_invoices_by_customer
  #   assert @sa.invoices_group_by_customer.all? do |k, v|
  #     k == v[0].id
  #   end
  # end
  #
  # def test_it_can_return_array_of_arrays_cust_id_total_spend
  #   assert_equal 1 , @sa.total_spend_per_customer.first[0]
  #   assert_instance_of BigDecimal, @sa.total_spend_per_customer.first[1]
  # end

  # def test_it_can_return_top_buyers
  #   assert_equal 2, @sa.top_buyers(2).count
  #   assert_equal 20, @sa.top_buyers.count
  # end
end
