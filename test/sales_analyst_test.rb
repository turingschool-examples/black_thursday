require_relative './test_helper'

class SalesAnalystTest < Minitest::Test
  def test_it_exist
    se = SalesEngine.from_csv({
    :items     => "./short_tests/short_items.csv",
    :merchants => "./short_tests/short_merchants.csv",
    })

    sales_analyst = SalesAnalyst.new(se)
    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_it_has_average_item_per_merchants
    se = SalesEngine.from_csv({
    :items     => "./short_tests/short_items.csv",
    :merchants => "./short_tests/short_merchants.csv",
    })

    sales_analyst = SalesAnalyst.new(se)

    assert_equal 2.33, sales_analyst.average_items_per_merchant
  end

  def test_it_has_average_items_per_merchants_standard_deviation
    se = SalesEngine.from_csv({
    :items     => "./short_tests/short_items.csv",
    :merchants => "./short_tests/short_merchants.csv",
    })

    sales_analyst = SalesAnalyst.new(se)

    assert_equal 1.53, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_can_count_merchants_with_a_high_count
    se = SalesEngine.from_csv({
    :items     => "./short_tests/short_items.csv",
    :merchants => "./short_tests/short_merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(se)
    merchant_1 = se.merchants.find_all_by_name("Candisart")

    assert_equal merchant_1,sales_analyst.merchants_with_high_item_count
  end

  def test_it_can_calculate_average_item_price_for_merchant
    se = SalesEngine.from_csv({
    :items     => "./short_tests/short_items.csv",
    :merchants => "./short_tests/short_merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(se)

    assert_instance_of BigDecimal, sales_analyst.average_item_price_for_merchant(3)
    assert_equal 12.25, sales_analyst.average_item_price_for_merchant(3).to_f
  end

  def test_it_can_calculate_the_average_of_all_merchants_per_price
    se = SalesEngine.from_csv({
    :items     => "./short_tests/short_items.csv",
    :merchants => "./short_tests/short_merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(se)

    assert_instance_of BigDecimal, sales_analyst.average_average_price_per_merchant
    assert_equal 11.58, sales_analyst.average_average_price_per_merchant.to_f
  end

  def test_it_can_calculate_the_average_item_cost
    se = SalesEngine.from_csv({
    :items     => "./short_tests/short_items.csv",
    :merchants => "./short_tests/short_merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 11.29, sales_analyst.average_item_cost.to_f
  end

  def test_it_has_golden_items_standard_deviation
    se = SalesEngine.from_csv({
    :items     => "./short_tests/short_items.csv",
    :merchants => "./short_tests/short_merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 8.56, sales_analyst.golden_items_standard_deviation
  end

  def test_it_can_sum_numbers_in_array
    se = SalesEngine.from_csv({
    :items     => "./short_tests/short_items.csv",
    :merchants => "./short_tests/short_merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 15, sales_analyst.sum_values([1,2,3,5,4])
  end

  def test_it_has_golden_items
    se = SalesEngine.from_csv({
    :items     => "./short_tests/short_items.csv",
    :merchants => "./short_tests/short_merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(se)
    item_1= se.items.update(3, unit_price: 35)
    se.items.update(7, unit_price: 15)
    se.items.update(1, unit_price: 9)
    se.items.update(6, unit_price: 12)
    se.items.update(2, unit_price: 10)
    se.items.update(4, unit_price: 9)
    se.items.update(5, unit_price: 20)

    assert_equal [item_1], sales_analyst.golden_items
  end

  def test_it_has_average_invoices_per_merchant
    se = SalesEngine.from_csv({
    :invoices     => "./data/invoices.csv",
    :merchants => "./data/merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 10.49, sales_analyst.average_invoices_per_merchant
  end

  def test_it_has_average_invoices_per_merchant_standard_deviation
    se = SalesEngine.from_csv({
    :invoices     => "./data/invoices.csv",
    :merchants => "./data/merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 3.29, sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_it_can_top_merchants_by_invoice_count
    se = SalesEngine.from_csv({
    :invoices     => "./data/invoices.csv",
    :merchants => "./data/merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 12, sales_analyst.top_merchants_by_invoice_count.length
  end

  def test_bottom_merchants_by_invoice_count
    se = SalesEngine.from_csv({
    :invoices     => "./data/invoices.csv",
    :merchants => "./data/merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 4, sales_analyst.bottom_merchants_by_invoice_count.length
  end

  def test_top_days_by_invoice_hash_returns_hash
    se = SalesEngine.from_csv({
    :invoices     => "./data/invoices.csv",
    :merchants => "./data/merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(se)

    assert_instance_of Hash, sales_analyst.day_and_invoice_count_hash
  end

  def test_average_invoice_per_day
    se = SalesEngine.from_csv({
    :invoices     => "./data/invoices.csv",
    :merchants => "./data/merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 712.14, sales_analyst.average_invoice_per_day
  end

  def test_average_day_per_invoice_standard_deviation
    se = SalesEngine.from_csv({
    :invoices     => "./data/invoices.csv",
    :merchants => "./data/merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 18.07, sales_analyst.average_day_per_invoice_standard_deviation
  end

  def test_top_days_by_invoice_count
    se = SalesEngine.from_csv({
    :invoices     => "./data/invoices.csv",
    :merchants => "./data/merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(se)

    assert_equal ["Wednesday"], sales_analyst.top_days_by_invoice_count
  end

  def test_invoice_status_returns_correct_percent
    se = SalesEngine.from_csv({
    :invoices     => "./data/invoices.csv",
    :merchants => "./data/merchants.csv",
    })
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 29.55, sales_analyst.invoice_status(:pending)
  end

  def test_it_can_find_invoice_paid_in_full
    se = SalesEngine.from_csv({
    :transactions => "./data/transactions.csv"
    })
    sales_analyst = SalesAnalyst.new(se)

    assert sales_analyst.invoice_paid_in_full?(2179)
    refute sales_analyst.invoice_paid_in_full?(731)
  end

  def test_it_has_invoice_total
    se = SalesEngine.from_csv({
    :invoice_items => "./data/invoice_items.csv"
    })
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 21067.77, sales_analyst.invoice_total(1)
  end

  def test_it_has_merchants_with_pending_invoices
    se = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :invoices => "./data/invoices.csv"})
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 467, sales_analyst.merchants_with_pending_invoices.length
  end

  def test_it_has_top_revenue_earners
    se = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :invoices => "./data/invoices.csv"})
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 12334634, sales_analyst.top_revenue_earners(10).first.id
  end

  def test_it_has_merchants_with_only_one_item
    se = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })
    sales_analyst = SalesAnalyst.new(se)

    m1 = se.merchants.find_by_id(12334141)
    m2 = se.merchants.find_by_id(12334207)
    m3 = se.merchants.find_by_id(12334235)
    m4 = se.merchants.find_by_id(12334183)
    m5 = se.merchants.find_by_id(12334303)
    m6 = se.merchants.find_by_id(12334113)

    assert_equal [m1,m2,m3,m4,m5,m6], sales_analyst.merchants_with_only_one_item[0..5]
  end

  def test_it_can_find_items_per_merchant_id
    se = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 2, sales_analyst.find_items_per_merchant_id(12334271).length
  end

  def test_it_can_calculate_revenue_by_merchant
    se = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :invoices => "./data/invoices.csv"})
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 91237.25, sales_analyst.revenue_by_merchant(12334271)
  end

  def test_it_has_merchants_with_only_one_item_registered_in_month
    se = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => "./data/merchants.csv"
    })
    sales_analyst = SalesAnalyst.new(se)

    assert_equal 21, sales_analyst.merchants_with_only_one_item_registered_in_month("March").length
    assert_equal 18, sales_analyst.merchants_with_only_one_item_registered_in_month("June").length
  end

  def test_most_sold_items_for_merchants
    se = SalesEngine.from_csv({
    :items => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :invoices => "./data/invoices.csv"})
    sales_analyst = SalesAnalyst.new(se)
    actual = sales_analyst.most_sold_item_for_merchant(12334189)

    assert_instance_of Array, actual
    assert_instance_of Item, actual[0]
    assert_equal 263524984, actual[0].id
  end

end
