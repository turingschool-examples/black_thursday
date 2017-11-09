require_relative "test_helper"
require_relative "../lib/sales_analyst"
require_relative "../lib/sales_engine"

class SalesAnalystTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_instance_of SalesAnalyst, sa
  end

  def test_it_can_find_average_items_per_merchant
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 4.33, sa.average_items_per_merchant
  end

  def test_it_can_find_merchant_list
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 15, sa.merchant_list.count
    assert_equal 12334105, sa.merchant_list.first
    assert_equal 12334160, sa.merchant_list.last
  end

  def test_it_can_find_number_of_items_merchant_sells
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 15, sa.find_items.count
    assert_equal 3, sa.find_items.first
    assert_equal 23, sa.find_items[4]
    assert_equal 1, sa.find_items.last
  end

  def test_it_can_find_standard_deviation_difference_total
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 488.99, sa.find_standard_deviation_difference_total
  end

  def test_it_can_find_standard_deviation_total
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 34.93, sa.find_standard_deviation_total.round(2)
  end

  def test_it_can_find_total_merchants_minus_one
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 14, sa.total_merchants_minus_one
  end

  def test_it_can_find_average_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 5.91, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_create_merchant_id_item_total_list_in_a_hash
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert Hash, sa.create_merchant_id_item_total_list
    assert_equal 15, sa.create_merchant_id_item_total_list.count
    assert_equal 12334105, sa.create_merchant_id_item_total_list.first.first
    assert_equal 3, sa.create_merchant_id_item_total_list[12334105]
  end

  def test_it_can_find_standard_deviation_plus_average
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 10.24, sa.standard_deviation_plus_average
  end

  def test_it_can_filter_merchants_by_items_in_stock_in_array
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert Array, sa.filter_merchants_by_items_in_stock
    assert_equal 12334123, sa.filter_merchants_by_items_in_stock.first.first
    assert_equal 23, sa.filter_merchants_by_items_in_stock.first.last
    assert_equal 12334123, sa.filter_merchants_by_items_in_stock.last.first
    assert_equal 23, sa.filter_merchants_by_items_in_stock.last.last
  end

  def test_it_can_find_merchants_with_high_item_count
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 1, sa.merchants_with_high_item_count.count
    assert_equal 12334123, sa.merchants_with_high_item_count.first.id
    #feel like this test should be more robust
  end

  def test_it_can_find_average_item_price_for_merchant
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 9.99, sa.average_item_price_for_merchant(12334105)
  end


  def test_it_can_find_the_collections_of_items
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert Array, sa.find_the_collections_of_items(12334105)
  end

  def test_it_can_find_average_average_price_per_merchant
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 35.77, sa.average_average_price_per_merchant
  end

  def test_it_can_find_average_unit_price
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 55.21, sa.average_unit_price
  end

  def test_it_can_find_unit_price_and_average_difference_squared_sum
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 126898.96, sa.unit_price_and_average_diff_sq_sum.round(2)
  end

  def test_it_can_find_unit_price_squared_sum_division
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 1982.8, sa.unit_price_squared_sum_division.round(2)
  end

  def test_it_can_find_unit_price_standard_deviation
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 44.53, sa.unit_price_standard_deviation
  end

  def test_it_can_find_golden_items_deviation
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 144.27, sa.golden_items_deviation
  end

  def test_it_can_find_golden_items
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 6, sa.golden_items.count
    assert_equal 263400121, sa.golden_items.first.id
    assert_equal 12334113, sa.golden_items.first.merchant_id
  end

  def test_it_can_find_average_invoices_per_merchant
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 10.8, sa.average_invoices_per_merchant
  end

  def test_it_can_find_invoice_totals
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert Array, sa.find_invoice_totals
    assert_equal 10, sa.find_invoice_totals.first
    assert_equal 9, sa.find_invoice_totals.last
  end

  def test_it_can_find_invoice_total_minus_average_squared
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 340.4, sa.invoice_total_minus_average_squared.round(2)
  end

  def test_it_can_find_invoice_difference_total_divided
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 24.31, sa.invoice_difference_total_divided.round(2)
  end

  def test_it_can_find_average_invoices_per_merchant_standard_deviation
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 4.93, sa.average_invoices_per_merchant_standard_deviation.round(2)
  end

  def test_it_can_find_invoice_count_two_standard_deviations_above_mean
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 20.66, sa.invoice_count_two_standard_deviations_above_mean.round(2)
  end

  def test_it_can_find_invoice_count_two_standard_deviations_below_mean
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 0.94, sa.invoice_count_two_standard_deviations_below_mean.round(2)
  end

  def test_it_can_create_merchant_invoice_total_list
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert Hash, sa.create_merchant_invoice_total_list
    assert_equal 15, sa.create_merchant_invoice_total_list.count
    assert_equal 12334105, sa.create_merchant_invoice_total_list.first.first
    assert_equal 10, sa.create_merchant_invoice_total_list.first.last
  end

  def test_it_can_find_bottom_merchants_by_invoice_count
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 12334132, sa.bottom_merchants_by_invoice_count.first.id
    assert_equal "perlesemoi", sa.bottom_merchants_by_invoice_count.first.name
    assert_equal 1, sa.bottom_merchants_by_invoice_count.count
  end

  def test_it_can_find_top_merchants_by_invoice_count
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 0, sa.top_merchants_by_invoice_count.count
  end

  def test_it_can_map_created_dates_to_weekdays
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 162, sa.map_created_dates_to_weekdays.count
  end

  def test_it_can_find_invoice_totals_by_day
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal ({"Monday"=>26, "Friday"=>22, "Tuesday"=>27, "Saturday"=>27, "Thursday"=>22, "Wednesday"=>21, "Sunday"=>17}), sa.invoice_totals_by_day
  end

  def test_it_can_find_invoice_per_day_average
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 23, sa.invoice_per_day_average
  end

  def test_it_can_find_invoice_totals_minus_average_squared
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 83, sa.invoice_totals_minus_average_squared
  end

  def test_it_can_find_weekday_invoice_total_difference_divided
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 13, sa.weekday_invoice_total_difference_divided
  end

  def test_it_can_find_weekday_invoice_creation_standard_deviation
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 3.61, sa.weekday_invoice_creation_standard_deviation
  end

  def test_it_can_find_invoice_creation_standard_deviation_plus_average
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 26.61, sa.invoice_creation_standard_deviation_plus_average
  end

  def test_it_can_find_top_days_by_invoice_count
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal ["Tuesday", "Saturday"], sa.top_days_by_invoice_count
  end

  def test_it_can_find_invoice_status_percentages
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 56.17, sa.invoice_status(:shipped)
    assert_equal 13.58, sa.invoice_status(:returned)
    assert_equal 30.25, sa.invoice_status(:pending)
  end

  def test_it_can_find_all_invoices_based_on_status
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 22, sa.find_all_invoices(:returned).count
    assert_equal 49, sa.find_all_invoices(:pending).count
    assert_equal 91, sa.find_all_invoices(:shipped).count
  end

  def test_it_can_find_all_invoices_by_date
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 14, sa.find_all_invoices_by_date(Time.parse("2005-01-03")).first.customer_id
    assert_equal 12334105, sa.find_all_invoices_by_date(Time.parse("2005-01-03")).first.merchant_id
  end

  def test_it_can_find_total_revenue_by_date
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 14496.62, sa.total_revenue_by_date(Time.parse("2005-01-03"))
  end

  def test_it_can_find_unit_price_to_dollars
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./test/fixtures/transactions_truncated.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 15, sa.unit_price_to_dollars(1500)
  end

  def test_it_can_find_all_invoices_by_date
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal true, sa.find_all_invoices_by_date(Time.parse("2005-01-03")).first.is_paid_in_full?

    invoice = sa.find_all_invoices_by_date(Time.parse("2005-01-03"))
    assert_equal 74, sa.filter_valid_invoices(invoice).first.id
  end

  def test_it_can_find_invoice_items_for_invoice_collection
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_truncated.csv",
      :merchants => "./test/fixtures/merchants_truncated.csv",
      :invoices => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    invoice = sa.find_all_invoices_by_date(Time.parse("2005-01-03"))

    assert_equal 6, sa.find_invoice_items_for_invoice_collection(invoice).count
    assert_equal 344, sa.find_invoice_items_for_invoice_collection(invoice).first.id
    assert_equal 349, sa.find_invoice_items_for_invoice_collection(invoice).last.id
  end
end
