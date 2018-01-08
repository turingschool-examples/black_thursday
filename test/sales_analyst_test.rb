require_relative "test_helper"
require_relative "../lib/sales_analyst"

class SalesAnalystTest < Minitest::Test

  def test_it_exist
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_instance_of SalesAnalyst, sa
  end

  def test_it_can_find_average_items_per_merchant
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 4.33, sa.average_items_per_merchant
  end

  def test_it_can_find_merchant_list
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 15, sa.merchant_list.count
    assert_equal 12334105, sa.merchant_list.first
    assert_equal 12334160, sa.merchant_list.last
  end

  def test_it_can_find_number_of_items_merchant_sells
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_instance_of Array, sa.find_items
    assert_equal 15, sa.find_items.count
    assert_equal 3, sa.find_items.first
    assert_equal 23, sa.find_items[4]
    assert_equal 1, sa.find_items.last
  end

  def test_it_can_find_standard_deviation_difference_total
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 488.99, sa.find_standard_dev_difference_total
  end

  def test_it_can_find_standard_deviation_total
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 34.93, sa.total_std_dev_sum_minus_one.round(2)
    assert_instance_of Float, sa.total_std_dev_sum_minus_one
  end

  def test_it_can_find_average_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 5.91, sa.average_items_per_merchant_standard_deviation
    assert_instance_of Float, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_create_merchant_id_item_total_list_in_a_hash
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert Hash, sa.merchants_by_item_count
    assert_equal 15, sa.merchants_by_item_count.count
    assert_equal 12334105, sa.merchants_by_item_count.first.first
    assert_equal 3, sa.merchants_by_item_count[12334105]
  end

  def test_it_can_find_standard_deviation_plus_average
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 10.24, sa.standard_dev_plus_average
    assert_instance_of Float, sa.standard_dev_plus_average
  end

  def test_it_can_filter_merchants_by_items_in_stock_in_array
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert Array, sa.merchants_by_items_in_stock
    assert_equal 12334123, sa.merchants_by_items_in_stock.first.first
    assert_equal 23, sa.merchants_by_items_in_stock.first.last
    assert_equal 12334123, sa.merchants_by_items_in_stock.last.first
    assert_equal 23, sa.merchants_by_items_in_stock.last.last
  end

  def test_it_can_find_merchants_with_high_item_count
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 1, sa.merchants_with_high_item_count.count
    assert_equal 12334123, sa.merchants_with_high_item_count.first.id
  end

  def test_it_can_find_all_merchant_items
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 3, sa.all_merchant_items(12334105).count
    assert_instance_of Array, sa.all_merchant_items(12334105)
  end

  def test_it_can_find_average_item_price_for_merchant
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 0.999e1, sa.average_item_price_for_merchant(12334105)
    assert_instance_of BigDecimal, sa.average_item_price_for_merchant(12334105)
  end

  def test_it_can_find_average_average_price_per_merchant
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 35.77, sa.average_average_price_per_merchant.to_f.round(2)
    assert_instance_of BigDecimal, sa.average_average_price_per_merchant
  end

  def test_it_can_find_average_unit_price
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 55.21, sa.average_unit_price
  end

  def test_it_can_find_unit_price_and_average_difference_squared_sum
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 0.12689896e6, sa.unit_price_and_average_sqr_sum.round(2)
    assert_instance_of BigDecimal, sa.unit_price_and_average_sqr_sum
  end

  def test_the_unit_price_standard_deviation_sum_minus_one
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal BigDecimal, sa.unit_price_std_dev_sum_minus_one.class
  end

  def test_it_can_find_unit_price_standard_deviation
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 44.53, sa.unit_price_stnd_dev
  end

  def test_it_can_find_golden_items_deviation
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 144.27, sa.golden_items_stnd_dev
  end

  def test_it_can_find_golden_items
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 6, sa.golden_items.count
    assert_equal 263400121, sa.golden_items.first.id
    assert_equal 12334113, sa.golden_items.first.merchant_id
  end

  def test_it_can_find_invoices
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 15, sa.find_invoices.count
    assert_equal 10, sa.find_invoices.first
    assert_equal 9, sa.find_invoices.last
  end

  def test_it_can_find_average_invoices_per_merchant
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 10.8, sa.average_invoices_per_merchant
    assert_instance_of Float, sa.average_invoices_per_merchant
  end

  def test_invoice_total_minus_average_squared_returns_total
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 340.40000000000003, sa.invoice_total_minus_average_squared
  end

  def test_invoice_diff_total_divided_returns_correct_amount
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 24.314285714285717, sa.invoice_diff_total_divided
    assert_instance_of Float, sa.invoice_diff_total_divided
  end

  def test_the_average_invoices_per_merchant_standard_deviation
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 4.93, sa.average_invoices_per_merchant_standard_deviation
    assert_instance_of Float, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_the_invoice_count_two_stnd_deviations_above_mean
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 20.66, sa.invoice_count_two_stnd_deviations_above_mean
    assert_instance_of Float, sa.invoice_count_two_stnd_deviations_above_mean
  end

  def test_the_invoice_count_two_stnd_deviations_below_mean
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 0.9400000000000013, sa.invoice_count_two_stnd_deviations_below_mean
    assert_instance_of Float, sa.invoice_count_two_stnd_deviations_below_mean
  end

  def test_merchants_invoice_total_list_is_returned
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 15, sa.merchants_invoice_total_list.count
    assert_equal 12334105, sa.merchants_invoice_total_list.first.first
    assert_equal 10, sa.merchants_invoice_total_list.first.last
    assert_instance_of Hash, sa.merchants_invoice_total_list
  end

  def test_top_merchants_are_returned
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
      })

    sa = SalesAnalyst.new(se)

    assert_equal 12, sa.top_merchants.count
    assert_equal [12334141, 18], sa.top_merchants.first
    assert_equal [12336430, 20], sa.top_merchants.last
  end

  def test_correct_top_merchants_by_invoice_count_are_returned
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
      })

    sa = SalesAnalyst.new(se)

    assert_instance_of Array, sa.top_merchants_by_invoice_count
    assert_equal "jejum", sa.top_merchants_by_invoice_count.first.name
    assert_equal 12334141, sa.top_merchants_by_invoice_count.first.id
  end

  def test_bottom_merchants_are_returned
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 1, sa.bottom_merchants.count
    assert_equal [12334132, 0], sa.bottom_merchants.first
  end

  def test_the_bottom_merchants_by_invoice_count_is_returned
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_instance_of Array, sa.bottom_merchants_by_invoice_count
    assert_equal 1, sa.bottom_merchants_by_invoice_count.count
    assert_equal "perlesemoi", sa.bottom_merchants_by_invoice_count.first.name
  end

  def test_created_days_to_week_days_returns_days_of_week
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)


    assert_instance_of Array, sa.created_days_to_week_days
    assert_equal 163, sa.created_days_to_week_days.count
  end

  def test_invoice_totals_by_day_returns_hash_of_weekdays_with_total_invoices_created
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_instance_of Hash, sa.invoice_totals_by_day
    assert_equal ({"Monday"=>26, "Friday"=>22, "Tuesday"=>28, "Saturday"=>27, "Thursday"=>22, "Wednesday"=>21, "Sunday"=>17}), sa.invoice_totals_by_day
  end

  def test_invoices_per_day_average_returns_invoices_per_day_average
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 23, sa.invoices_per_day_average
  end

  def test_invoice_totals_minus_avg_sqrd_returns_invoice_totals_minus_avg_sqrd
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 92, sa.invoice_totals_minus_avg_sqrd
  end

  def test_invoice_total_diff_sqrd_returns_invoice_total_diff_sqrd
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 15, sa.invoice_total_diff_sqrd
  end

  def test_weekday_invoice_stnd_deviation_returns_weekday_invoice_stnd_deviation
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

  assert_equal 3.87, sa.weekday_invoice_stnd_deviation
  end

  def test_weekday_invoice_stnd_deviation_plus_avg_returns_weekday_invoice_stnd_deviation_plus_avg
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 26.87, sa.weekday_invoice_stnd_deviation_plus_avg
  end

  def test_top_days_by_invoice_count_returns_top_day_by_invoice_count
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal ["Tuesday", "Saturday"], sa.top_days_by_invoice_count
  end

  def test_all_invoices_by_status_returns_all_invoices_by_status
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_instance_of Array, sa.all_invoices_by_status(:pending)
    assert_instance_of Array, sa.all_invoices_by_status(:shipped)
    assert_instance_of Array, sa.all_invoices_by_status(:returned)
    assert_equal 49, sa.all_invoices_by_status(:pending).count
    assert_equal 91, sa.all_invoices_by_status(:shipped).count
    assert_equal 23, sa.all_invoices_by_status(:returned).count
  end

  def test_invoice_status_returns_percent_based_on_given_status
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 14.11, sa.invoice_status(:returned)
    assert_equal 55.83, sa.invoice_status(:shipped)
    assert_equal 30.06, sa.invoice_status(:pending)
  end
end
