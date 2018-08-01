require_relative './test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(items:  './data/fake_item_csv.csv',
                               merchants: './data/fake_merchant_csv.csv',
                               invoices: './data/fake_invoice_csv.csv',
                               transactions: './data/fake_transaction_csv.csv',
                               invoice_items: './data/fake_invoice_items_csv.csv')

    @sa = SalesAnalyst.new(@se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_can_create_instance_of_sales_engine
    assert_instance_of SalesEngine, @se
  end

  def test_it_can_group_items_by_merchant_id
    assert_equal 1, @sa.group_items_by_merchant[1].count
    assert_equal 3, @sa.group_items_by_merchant[3].count
  end

  def test_it_can_find_number_of_merchants
    assert_equal 5, @sa.find_number_of_merchants_for_items
  end

  def test_it_can_find_number_items
    assert_equal 13, @sa.find_total_number_of_items
  end

  def test_it_can_find_average_items_per_merchant
    assert_equal 2.6, @sa.average_items_per_merchant
    assert_equal Float, @sa.average_items_per_merchant.class
  end

  def test_it_can_find_average_items_per_merchant_standard_deviation
    assert_equal 1.14, @sa.average_items_per_merchant_standard_deviation
    assert_equal Float, @sa.average_items_per_merchant_standard_deviation.class
  end

  def test_it_can_find_number_of_items_for_each_merchant
    assert_equal [1, 2, 3, 4, 3], @sa.items_per_merchant
  end

  def test_it_can_find_variance
    item_count_array = [2, 3, 4, 3, 5]
    average = 3.4
    assert_equal 5.2, @sa.variance(average, item_count_array)
  end

  def test_it_can_find_square_root_of_variance
    v = 5.2
    ipm = [2, 3, 4, 3, 5]
    assert_equal 1.14, @sa.square_root_of_variance(v, ipm)
  end

  def test_it_can_find_one_stnd_deviation_above_average
    assert_equal 3.74, @sa.items_one_standard_deviation_above
  end

  def test_it_can_zip_merchant_ids_and_item_quantities
    # merchant id first, then item quantity
    expected = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 3]]
    assert_equal expected, @sa.item_amount_per_merchant
  end

  def test_it_can_find_high_seller_merchants
    # high seller merchants have >= 3.74 items
    assert_equal 1, @sa.merchants_with_high_item_count.count
    assert_equal Array, @sa.merchants_with_high_item_count.class
    assert_equal Merchant, @sa.merchants_with_high_item_count.first.class
  end

  def test_it_can_find_average_item_price_for_single_merchant
    assert_equal 16.5, @sa.average_item_price_for_merchant(4)
    assert_equal BigDecimal, @sa.average_item_price_for_merchant(4).class
  end

  def test_it_can_find_average_average_price_per_merchant
    assert_equal 15.73, @sa.average_average_price_per_merchant
    assert_equal BigDecimal, @sa.average_average_price_per_merchant.class
  end

  def test_it_can_find_average_item_prices_for_each_merchant
    assert_equal 5, @sa.average_item_prices_for_each_merchant.count
    assert_equal BigDecimal, @sa.average_item_prices_for_each_merchant[0].class
  end

  def test_it_can_find_item_price_average
    assert_equal 17.23, @sa.item_price_average
  end

  def test_it_can_find_all_item_prices
    assert_equal 13, @sa.all_item_prices.count
  end

  def test_it_can_find_standard_deviation_for_item_price
    assert_equal 10.43, @sa.standard_deviation_for_item_price
  end

  def test_it_can_find_golden_items
    assert_equal 1, @sa.golden_items.count
  end

  def test_it_can_group_invoices_by_merchant_id
    assert_equal 1, @sa.group_invoices_by_merchant[1].count
    assert_equal 3, @sa.group_invoices_by_merchant[3].count
  end

  def test_it_can_find_number_invoices
    assert_equal 13, @sa.find_total_number_of_invoices
  end

  def test_it_can_find_average_invoices_per_merchant
    assert_equal 2.6, @sa.average_invoices_per_merchant
    assert_equal Float, @sa.average_invoices_per_merchant.class
  end

  def test_it_can_find_average_invoices_per_merchant_standard_deviation
    assert_equal 1.14, @sa.average_invoices_per_merchant_standard_deviation
    actual = @sa.average_invoices_per_merchant_standard_deviation.class
    assert_equal Float, actual
  end

  def test_it_can_find_number_of_invoices_for_each_merchant
    assert_equal [1, 2, 3, 4, 3], @sa.invoices_per_merchant
  end

  def test_it_can_find_invoices_two_standard_deviations_above_average
    assert_equal 4.88, @sa.invoices_two_standard_deviations_above
  end

  def test_it_groups_top_merchants_by_invoice_count_over_two_standard_deviations
    assert_equal 0, @sa.top_merchants_by_invoice_count.count
    assert_equal [], @sa.bottom_merchants_by_invoice_count
  end

  def test_it_can_find_two_standard_deviations_below_average
    assert_equal 0.32, @sa.invoices_two_standard_deviations_below
  end

  def test_it_finds_bottom_merchants_by_invoice_count_below_two_std_devs
    assert_equal 0, @sa.bottom_merchants_by_invoice_count.count
    assert_equal [], @sa.bottom_merchants_by_invoice_count
  end

  def test_it_can_group_invoices_by_date
    assert_equal 7, @sa.group_invoices_by_day_created.count
    assert_equal [0, 1, 2, 3, 4, 5, 6], @sa.group_invoices_by_day_created.keys
    assert_equal 4, @sa.group_invoices_by_day_created[0].count #Sunday
    assert_equal 1, @sa.group_invoices_by_day_created[1].count #Monday
    assert_equal 1, @sa.group_invoices_by_day_created[2].count #Tuesday
    assert_equal 1, @sa.group_invoices_by_day_created[3].count #Wednesday
    assert_equal 1, @sa.group_invoices_by_day_created[4].count #Thursday
    assert_equal 2, @sa.group_invoices_by_day_created[5].count #Friday
    assert_equal 3, @sa.group_invoices_by_day_created[6].count #Saturday
  end

  def test_it_can_find_number_of_days_for_invoices
    assert_equal 7, @sa.find_number_of_days_for_invoices
  end

  def test_it_can_find_total_number_of_invoices
    assert_equal 13, @sa.find_total_number_of_invoices
  end

  def test_it_can_find_average_number_of_invoices_per_day
    assert_equal 1.86, @sa.average_invoices_per_day
  end

  def test_it_can_find_average_invoices_per_day_standard_deviation
    assert_equal 1.21, @sa.average_invoices_per_day_standard_deviation
    assert_equal Float, @sa.average_invoices_per_day_standard_deviation.class
  end

  def test_it_can_find_invoices_per_day_one_standard_deviation_above_average
    assert_equal 3.07, @sa.invoices_per_day_one_standard_deviation_above
  end

  def test_it_groups_top_days_by_invoice_count_over_one_standard_deviation
    assert_equal 1, @sa.top_days_by_invoice_count.count
    assert_equal ['Sunday'], @sa.top_days_by_invoice_count
  end

  def test_it_can_find_percentage_of_invoices
    assert_equal 7.69, @sa.invoice_status(:returned)
    assert_equal 53.85, @sa.invoice_status(:shipped)
    assert_equal 38.46, @sa.invoice_status(:pending)
  end

  def test_it_can_group_invoices_by_status
    assert_equal 3, @sa.group_invoices_by_status.count
    expected = [:returned, :shipped, :pending]

    assert_equal expected, @sa.group_invoices_by_status.keys
    assert_equal 1, @sa.group_invoices_by_status[:returned].count
    assert_equal 7, @sa.group_invoices_by_status[:shipped].count
    assert_equal 5, @sa.group_invoices_by_status[:pending].count
  end

  def test_invoice_paid_in_full
    assert_equal true, @sa.invoice_paid_in_full?(2)
    assert_equal true, @sa.invoice_paid_in_full?(12)
    assert_equal false, @sa.invoice_paid_in_full?(9999)
  end

  def test_it_can_calculate_invoice_total
    assert_equal BigDecimal, @sa.invoice_total(3).class
    assert_equal BigDecimal, @sa.invoice_total(4).class
  end

  def test_it_can_find_total_revenue_by_date
    date = Time.parse('2018-07-23')
    assert_equal BigDecimal, @sa.total_revenue_by_date(date).class
  end

  def test_it_can_find_invoices_by_created_at_date
    date = Time.parse('2018-07-23')
    assert_equal Array, @sa.find_all_invoices_by_date(date).class
    assert_equal 1, @sa.find_all_invoices_by_date(date).count
  end

  def test_it_can_find_the_top_number_of_revenue_earners
    assert_equal 2, @sa.top_revenue_earners(2).count
    assert_equal Merchant, @sa.top_revenue_earners(2).first.class
    assert_equal 3, @sa.top_revenue_earners(2).first.id
    assert_equal 2, @sa.top_revenue_earners(2).last.id
  end

  def test_invoice_hash
    assert_equal Array, @sa.invoice_hash[1].class
    assert_equal 1, @sa.invoice_hash[1].count
  end

  def test_it_can_sum_invoice_totals
    assert_equal 2780.91, @sa.sum_invoice_totals[1].to_f
  end

  def test_it_can_sort_summed_invoice_totals
    assert_equal 2, @sa.sort_summed_invoice_totals(2).count
  end

  def test_it_can_get_merchant_id_for_pending_invoices
    assert_equal [4, 5], @sa.get_merchant_id_for_pending_invoices
  end

  def test_it_can_group_merchants_with_pending_invoices
    merchant_1 = @sa.merchants_with_pending_invoices[0]
    merchant_2 = @sa.merchants_with_pending_invoices[1]

    assert_equal [merchant_1, merchant_2], @sa.merchants_with_pending_invoices
    assert_equal Merchant, @sa.merchants_with_pending_invoices.first.class
    assert_equal 2, @sa.merchants_with_pending_invoices.count
  end

  def test_it_ranks_merchants_by_revenue
    assert_equal Merchant, @sa.merchants_ranked_by_revenue.first.class
    assert_equal 3, @sa.merchants_ranked_by_revenue.first.id
  end

  def test_it_can_collect_merchant_ids_with_one_item
    assert_equal 1, @sa.get_merchant_ids_with_one_item.count
    assert_equal ({ 1 => 1 }), @sa.get_merchant_ids_with_one_item
  end

  def test_groups_merchants_with_only_one_item
    assert_equal 1, @sa.merchants_with_only_one_item.count
    assert_equal Merchant, @sa.merchants_with_only_one_item.first.class
  end

  def test_it_can_group_merchants_with_one_item_by_month_created_at
    actual = @sa.merchants_with_only_one_item_registered_in_month('December')
    assert_equal 1, actual.count
    assert_equal Merchant, actual.first.class
  end

  def test_it_can_find_a_merchants_total_revenue_by_merchant_id
    assert_equal 2780.91, @sa.revenue_by_merchant(1).to_f
    assert_equal BigDecimal, @sa.revenue_by_merchant(1).class
  end

  def test_can_find_a_merchants_most_sold_item
    assert_equal Array, @sa.most_sold_item_for_merchant(4).class
    assert_equal Item, @sa.most_sold_item_for_merchant(4).first.class
    assert_equal 'NineThing', @sa.most_sold_item_for_merchant(4).first.name
    assert_equal 1, @sa.most_sold_item_for_merchant(4).count
  end

  def test_it_can_get_paid_invoices_per_merchant
    assert_equal 2, @sa.pull_paid_invoices_per_merchant(4).count
    assert_equal Invoice, @sa.pull_paid_invoices_per_merchant(4).first.class
    assert_equal 7, @sa.pull_paid_invoices_per_merchant(4).first.id
    assert_equal 9, @sa.pull_paid_invoices_per_merchant(4).last.id
  end

  def test_it_can_find_all_paid_invoice_items_by_invoice_id
    paid_invoices = @sa.pull_paid_invoices_per_merchant(4)

    assert_equal 2, @sa.find_all_paid_invoice_items_by_id(paid_invoices).count
    assert_equal 7, @sa.find_all_paid_invoice_items_by_id(paid_invoices).first.invoice_id
    assert_equal 9, @sa.find_all_paid_invoice_items_by_id(paid_invoices).last.invoice_id
    assert_equal InvoiceItem, @sa.find_all_paid_invoice_items_by_id(paid_invoices).first.class
  end

  def test_it_can_find_invoice_item_quantities_sold_by_merchant
    paid_invoices = @sa.pull_paid_invoices_per_merchant(4)
    paid_invoice_items = @sa.find_all_paid_invoice_items_by_id(paid_invoices)

    assert_equal 2, @sa.sold_invoice_item_quantities(paid_invoice_items).count
    assert_equal ({ 7 => 4, 9 => 6 }), @sa.sold_invoice_item_quantities(paid_invoice_items)
  end

  def test_it_can_find_a_merchants_best_selling_item_by_quantity
    paid_invoices = @sa.pull_paid_invoices_per_merchant(4)
    paid_invoice_items = @sa.find_all_paid_invoice_items_by_id(paid_invoices)
    quantities = @sa.sold_invoice_item_quantities(paid_invoice_items)

    assert_equal Array, @sa.top_selling_item_by_quantity(quantities).class
    assert_equal Item, @sa.top_selling_item_by_quantity(quantities).first.class
    assert_equal 'NineThing', @sa.top_selling_item_by_quantity(quantities).first.name
    assert_equal 1, @sa.top_selling_item_by_quantity(quantities).count
  end

  def test_it_can_find_a_merchants_best_selling_item_by_revenue
    paid_invoices = @sa.pull_paid_invoices_per_merchant(4)
    paid_invoice_items = @sa.find_all_paid_invoice_items_by_id(paid_invoices)
    revenues = @sa.sold_invoice_item_revenues(paid_invoice_items)

    assert_equal Array, @sa.top_selling_item_by_revenue(revenues).class
    assert_equal Item, @sa.top_selling_item_by_revenue(revenues).first.class
    assert_equal 'SevenThing', @sa.top_selling_item_by_revenue(revenues).first.name
    assert_equal 1, @sa.top_selling_item_by_revenue(revenues).count
  end

  def test_it_can_find_invoice_item_revenues_received_by_merchant
    paid_invoices = @sa.pull_paid_invoices_per_merchant(4)
    paid_invoice_items = @sa.find_all_paid_invoice_items_by_id(paid_invoices)

    assert_equal 2, @sa.sold_invoice_item_revenues(paid_invoice_items).count
    assert_equal [7, 9], @sa.sold_invoice_item_revenues(paid_invoice_items).keys
  end

  def test_it_can_find_a_merchants_best_selling_item_by_price
    paid_invoices = @sa.pull_paid_invoices_per_merchant(4)
    paid_invoice_items = @sa.find_all_paid_invoice_items_by_id(paid_invoices)
    revenues = @sa.sold_invoice_item_quantities(paid_invoice_items)

    assert_equal Array, @sa.top_selling_item_by_revenue(revenues).class
    assert_equal Item, @sa.top_selling_item_by_revenue(revenues).first.class
    assert_equal 'NineThing', @sa.top_selling_item_by_revenue(revenues).first.name
    assert_equal 1, @sa.top_selling_item_by_revenue(revenues).count
  end
end
