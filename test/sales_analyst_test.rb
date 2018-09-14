require_relative './test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'

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
    merchant_1 = se.merchants.find_all_by_name("Candisart")

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
    item_2= se.items.update(7, unit_price: 15)
    item_3= se.items.update(1, unit_price: 9)
    item_4= se.items.update(6, unit_price: 12)
    item_5= se.items.update(2, unit_price: 10)
    item_6= se.items.update(4, unit_price: 9)
    item_7 = se.items.update(5, unit_price: 20)

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



end
