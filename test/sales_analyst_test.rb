require_relative "test_helper"
require_relative "../lib/sales_analyst"

class SalesAnalystTest < Minitest::Test

  def test_it_exist
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)
    
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_can_find_average_items_per_merchant
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_it_can_find_merchant_list
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)
    
    assert_equal 475, sa.merchant_list.count
    assert_equal 12334105, sa.merchant_list.first
    assert_equal 12337411, sa.merchant_list.last
  end

  def test_it_can_find_number_of_items_merchant_sells
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_instance_of Array, sa.find_items
    assert_equal 475, sa.find_items.count
    assert_equal 3, sa.find_items.first
    assert_equal 25, sa.find_items[4]
    assert_equal 1, sa.find_items.last
  end

  def test_it_can_find_standard_deviation_difference_total
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 5034.92, sa.find_standard_dev_difference_total
  end

  def test_it_can_find_standard_deviation_total
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 10.62, sa.total_std_dev_sum_minus_one.round(2)
    assert_instance_of Float, sa.total_std_dev_sum_minus_one
  end

  def test_it_can_find_average_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
    assert_instance_of Float, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_can_create_merchant_id_item_total_list_in_a_hash
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert Hash, sa.merchants_by_item_count
    assert_equal 475, sa.merchants_by_item_count.count
    assert_equal 12334105, sa.merchants_by_item_count.first.first
    assert_equal 3, sa.merchants_by_item_count[12334105]
  end

  def test_it_can_find_standard_deviation_plus_average
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 6.14, sa.standard_dev_plus_average
    assert_instance_of Float, sa.standard_dev_plus_average
  end

  def test_it_can_filter_merchants_by_items_in_stock_in_array
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert Array, sa.merchants_by_items_in_stock
    assert_equal 12334123, sa.merchants_by_items_in_stock.first.first
    assert_equal 25, sa.merchants_by_items_in_stock.first.last
    assert_equal 12336965, sa.merchants_by_items_in_stock.last.first
    assert_equal 10, sa.merchants_by_items_in_stock.last.last
  end

  def test_it_can_find_merchants_with_high_item_count
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 52, sa.merchants_with_high_item_count.count
    assert_equal 12334123, sa.merchants_with_high_item_count.first.id
  end

  def test_it_can_find_all_merchant_items
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 3, sa.all_merchant_items(12334105).count
    assert_instance_of Array, sa.all_merchant_items(12334105)
  end

  def test_it_can_find_average_item_price_for_merchant
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 0.1666e2, sa.average_item_price_for_merchant(12334105)
    assert_instance_of BigDecimal, sa.average_item_price_for_merchant(12334105)
  end

  def test_it_can_find_average_average_price_per_merchant
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 0.35029e3, sa.average_average_price_per_merchant.round(2)
    assert_instance_of BigDecimal, sa.average_average_price_per_merchant
  end

  def test_it_can_find_average_unit_price
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 251.06, sa.average_unit_price
  end

  def test_it_can_find_unit_price_and_average_difference_squared_sum
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 0.1149590488981e11, sa.unit_price_and_average_sqr_sum.round(2)
    assert_instance_of BigDecimal, sa.unit_price_and_average_sqr_sum
  end

  def test_the_unit_price_standard_deviation_sum_minus_one
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal BigDecimal, sa.unit_price_std_dev_sum_minus_one.class
  end

  def test_it_can_find_unit_price_standard_deviation
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 2900.99, sa.unit_price_stnd_dev
  end

  def test_it_can_find_golden_items_deviation
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 6053.04, sa.golden_items_stnd_dev
  end

  def test_it_can_find_golden_items
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 5, sa.golden_items.count
    assert_equal 263410685, sa.golden_items.first.id
    assert_equal 12334499, sa.golden_items.first.merchant_id
  end

  def test_it_can_find_invoices
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 475, sa.find_invoices.count
    assert_equal 10, sa.find_invoices.first
    assert_equal 7, sa.find_invoices.last
  end

  def test_it_can_find_average_invoices_per_merchant
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 10.49, sa.average_invoices_per_merchant
    assert_instance_of Float, sa.average_invoices_per_merchant
  end

  def test_invoice_total_minus_average_squared_returns_total
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 5132.74749999999, sa.invoice_total_minus_average_squared
  end

  def test_invoice_diff_total_divided_returns_correct_amount
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 10.828581223628671, sa.invoice_diff_total_divided
    assert_instance_of Float, sa.invoice_diff_total_divided
  end

  def test_the_average_invoices_per_merchant_standard_deviation
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 3.29, sa.average_invoices_per_merchant_standard_deviation
    assert_instance_of Float, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_the_invoice_count_two_stnd_deviations_above_mean
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 17.07, sa.invoice_count_two_stnd_deviations_above_mean
    assert_instance_of Float, sa.invoice_count_two_stnd_deviations_above_mean
  end

  def test_the_invoice_count_two_stnd_deviations_below_mean
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 3.91, sa.invoice_count_two_stnd_deviations_below_mean
    assert_instance_of Float, sa.invoice_count_two_stnd_deviations_below_mean
  end

  def test_merchants_invoice_total_list_is_returned
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 475, sa.merchants_invoice_total_list.count
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
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_equal 4, sa.bottom_merchants.count
    assert_equal [12334235, 3], sa.bottom_merchants.first
    assert_equal [12335560, 3], sa.bottom_merchants.last
  end

  def test_the_bottom_merchants_by_invoice_count_is_returned
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_instance_of Array, sa.bottom_merchants_by_invoice_count
    assert_equal 4, sa.bottom_merchants_by_invoice_count.count
    assert_equal "WellnessNeelsen", sa.bottom_merchants_by_invoice_count.first.name
    assert_equal "LoganNortonPhotos", sa.bottom_merchants_by_invoice_count.last.name
  end  

end



