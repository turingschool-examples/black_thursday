require_relative '../test/test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_has_attributes
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst
    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of ItemRepository, se.items
    assert_instance_of InvoiceRepository, se.invoices
  end

  def test_it_calculates_average_items_per_merchant
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_it_calculates_standard_deviation
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_finds_merchants_with_high_item_count
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst

    # update expected
    expected = 52
    assert_equal expected, sa.merchants_with_high_item_count.count
  end

  def test_it_finds_average_item_price_for_merchant
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst

    expected = BigDecimal(31.5, 4)
    assert_equal expected, sa.average_item_price_for_merchant(12334159)
  end

  def test_it_finds_average_average_price_per_merchant
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst

    expected = BigDecimal(350.29, 5)
    assert_equal expected, sa.average_average_price_per_merchant
  end

  def test_it_can_find_golden_items
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst

    assert_equal 5, sa.golden_items.count
  end

  # --------- Tests for Helper Methods ----------

  def test_it_can_count_items_per_id
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst

    assert_equal 475, sa.item_count_per_merchant_id.count
  end

  def test_it_can_square_differences
    se = SalesEngine.from_csv(
      :items     => "./test/fixtures/items.csv",
      :merchants => "./test/fixtures/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst
    values = [4,5,6,7,8,9,10]
    average = 7
    expected = [9, 4, 1, 0, 1, 4, 9]

    assert_equal expected, sa.square_differences(values, average)
  end

  def test_it_can_sum
    se = SalesEngine.from_csv(
      :items     => "./test/fixtures/items.csv",
      :merchants => "./test/fixtures/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst
    values = [4,5,6,7,8,9,10]

    assert_equal 49, sa.sum(values)
  end

  def test_it_can_find_merchant_ids_with_high_item_count
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst

    hash = sa.item_count_per_merchant_id

    assert_equal 52, sa.merchant_ids_with_high_item_count(hash).count
    assert_equal [12334195, 20], sa.merchant_ids_with_high_item_count(hash)[0]

  end

  def test_it_can_find_merchants_from_ids
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst

    hash = sa.item_count_per_merchant_id
    ids = sa.merchant_ids_with_high_item_count(hash)
    assert_equal 52,  sa.merchants_from_ids(ids).count
    expected = se.merchants.find_by_id(ids[0][0])
    assert_equal expected, sa.merchants_from_ids(ids)[0]
  end

  def test_it_can_find_prices_for_merchants
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst

    hash = sa.item_count_per_merchant_id

    assert_equal 20, sa.find_prices_for_merchant(12334195).count
    assert_equal 149, sa.find_prices_for_merchant(12334195)[0]
  end

  def test_it_can_average_numbers
    se = SalesEngine.from_csv(
      :items     => "./test/fixtures/items.csv",
      :merchants => "./test/fixtures/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst
    values = [4,5,6,7,8,9,10]

    assert_equal 7, sa.average(values)
  end

  def test_it_can_find_prices
    se = SalesEngine.from_csv(
      :items     => "./test/fixtures/items.csv",
      :merchants => "./test/fixtures/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst

    expected = [12, 13, 13.5, 7, 29.99, 149]
    assert_equal expected, sa.find_prices
  end

  def test_it_can_find_golden_items_from_threshold
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst
    threshold = 6051
    assert_equal 5, sa.find_golden_items(se.items.all, threshold).count
  end

  def test_it_calculates_average_invoices_per_merchant
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst
    assert_equal 10.49, sa.average_invoices_per_merchant
  end

  def test_it_calculates_standard_deviation_for_invoices
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst
    assert_equal 3.29, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_it_can_count_invoices_per_id
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst

    assert_equal 475, sa.invoice_count_per_merchant_id.count
  end

  def test_can_calculate_two_above_the_standard_deviation
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst

    assert_equal 17.07, sa.two_above_standard_deviation
  end

  def test_can_find_the_top_merchants_two_standard_deviations_above_the_mean
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst

    assert_equal 12, sa.top_merchants_by_invoice_count.count
  end

  def test_can_calculate_two_below_the_standard_deviation
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst

    assert_equal 3.91, sa.two_below_standard_deviation
  end

  def test_can_find_the_bottom_merchants_two_standard_deviations_below_the_mean
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst

    assert_equal 4, sa.bottom_merchants_by_invoice_count.count
  end

  def test_can_get_top_days_based_on_invoice_count
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst

    assert_equal ["Wednesday"], sa.top_days_by_invoice_count
  end


  def test_can_group_invoices_by_day_of_the_week
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst

    assert_equal ["Saturday", "Friday", "Wednesday", "Monday", "Sunday", "Tuesday", "Thursday"], sa.group_invoices_by_days_of_the_week.keys
  end

  def test_can_average_invoices_for_days_of_the_week
      se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst

    assert_equal 712.14, sa.average_invoices_per_day
  end

  def test_can_calculate_difference_of_invoices_per_day_and_average
    se = SalesEngine.from_csv(
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices  => "./data/invoices.csv"
  )
  sa = se.analyst

  assert_equal 16.86, sa.differences_by_day("Saturday")

  assert_equal (-16.14), sa.differences_by_day("Monday")

  assert_equal 28.86, sa.differences_by_day("Wednesday")
  end

  def test_it_can_square_differences_by_day
    se = SalesEngine.from_csv(
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices  => "./data/invoices.csv"
  )
  sa = se.analyst

  assert_equal 284.26, sa.differences_by_day_squared("Saturday")

  assert_equal 260.5, sa.differences_by_day_squared("Monday")

  assert_equal 832.9, sa.differences_by_day_squared("Wednesday")
  end

  def test_can_calculate_standard_deviation_by_day
    se = SalesEngine.from_csv(
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices  => "./data/invoices.csv"
  )
  sa = se.analyst

  sa.differences_by_day_squared("Wednesday")

  assert_equal 18.07, sa.calculate_sd_by_day
  end

  def test_it_can_group_invoices_by_status
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst

    assert_equal [:pending, :shipped, :returned], sa.invoices_grouped_by_status.keys
  end

  def test_can_find_percentage_by_invoice_status
    se = SalesEngine.from_csv(
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices  => "./data/invoices.csv"
    )
    sa = se.analyst

    assert_equal 29.55, sa.invoice_status(:pending)

    assert_equal 56.95, sa.invoice_status(:shipped)

    assert_equal 13.5, sa.invoice_status(:returned)
  end
end
