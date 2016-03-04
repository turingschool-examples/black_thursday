require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'

class SalesAnalystTest < Minitest::Test
  def test_sales_analyst_can_be_instantiated_with_sales_engine
    se = SalesEngine.from_csv({
      :items     => "data/items.csv",
      :merchants => "data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)
    assert sa
  end

  def test_can_calculate_average_items_per_merchant
    se = SalesEngine.from_csv({
      :items     => "data/items.csv",
      :merchants => "data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_can_calculate_average_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv({
      :items     => "data/items.csv",
      :merchants => "data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_can_calculate_number_for_one_std_dev_for_average_items_per_merchant
    se = SalesEngine.from_csv({
      :items     => "data/items.csv",
      :merchants => "data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)
    assert_equal 6.14, sa.one_std_dev_for_average_items_per_merchant
  end

  def test_can_calculate_merchants_more_than_one_std_dev_from_avg_number_of_products_offered
    se = SalesEngine.from_csv({
      :items     => "data/items.csv",
      :merchants => "data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)
    assert_equal 52, sa.merchants_with_high_item_count.count
  end

  def test_can_calculate_average_item_price_for_specific_merchant_id_for_merchants_with_high_item_count
    se = SalesEngine.from_csv({
      :items     => "data/items.csv",
      :merchants => "data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)
    assert_equal BigDecimal, sa.average_item_price_for_merchant("12334105").class
    assert_equal 1665.00, sa.average_item_price_for_merchant("12334105").to_f.round(2)
  end

  def test_can_calculate_sum_of_all_the_averages_to_find_average_price_across_all_merchants
    se = SalesEngine.from_csv({
      :items     => "data/items.csv",
      :merchants => "data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)

    assert_equal BigDecimal, sa.average_average_price_per_merchant.class
    assert_equal 35029.40, sa.average_average_price_per_merchant.to_f.round(2)
  end

  def test_can_calculate_average_item_price_per_merchant_standard_deviation
    se = SalesEngine.from_csv({
      :items     => "test/fake_items.csv",
      :merchants => "test/fake_merchants.csv",
    })
    sa = SalesAnalyst.new(se)
    assert_equal 69.30, sa.average_item_price_standard_deviation
  end

  def test_can_calculate_number_for_two_std_dev_for_average_item_price
    se = SalesEngine.from_csv({
      :items     => "test/fake_items.csv",
      :merchants => "test/fake_merchants.csv",
    })
    sa = SalesAnalyst.new(se)
    assert_equal 15322.84, sa.two_std_dev_for_average_item_price
  end

  def test_can_calculate_golden_items
    se = SalesEngine.from_csv({
      :items     => "test/fake_items.csv",
      :merchants => "test/fake_merchants.csv",
    })
    sa = SalesAnalyst.new(se)
    assert_equal 0, sa.golden_items.count
  end

  def test_can_calculate_average_invoices_per_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => "data/items.csv",
      :merchants => "data/merchants.csv",
      :invoices => "data/invoices.csv"
    })
    sa = SalesAnalyst.new(sales_engine)
    expected = 10.49
    assert_equal expected, sa.average_invoices_per_merchant
    assert_equal Float, expected.class
  end

  def test_can_calculate_average_invoices_per_merchant_standard_deviation
    sales_engine = SalesEngine.from_csv({
      :items     => "data/items.csv",
      :merchants => "data/merchants.csv",
      :invoices => "data/invoices.csv"
    })
    sa = SalesAnalyst.new(sales_engine)
    expected = 3.29
    assert_equal expected, sa.average_invoices_per_merchant_standard_deviation
    assert_equal Float, expected.class
  end

  def test_can_calculate_two_std_dev_average_invoice_count
    sales_engine = SalesEngine.from_csv({
      :items     => "data/items.csv",
      :merchants => "data/merchants.csv",
      :invoices => "data/invoices.csv"
    })
    sa = SalesAnalyst.new(sales_engine)
    expected = 6.58
    assert_equal expected, sa.two_std_dev_average_invoice_count
  end

  def test_can_calculate_number_for_two_std_dev_above_average_invoice_count
    sales_engine = SalesEngine.from_csv({
      :items     => "data/items.csv",
      :merchants => "data/merchants.csv",
      :invoices => "data/invoices.csv"
    })
    sa = SalesAnalyst.new(sales_engine)
    expected = 17.07
    assert_equal expected, sa.two_std_dev_above_average_invoice_count
    assert_equal Float, expected.class
  end

  def test_can_calculate_two_std_dev_below_average_invoice_count
    sales_engine = SalesEngine.from_csv({
      :items     => "data/items.csv",
      :merchants => "data/merchants.csv",
      :invoices => "data/invoices.csv"
    })
    sa = SalesAnalyst.new(sales_engine)
    expected = 3.91
    assert_equal expected, sa.two_std_dev_below_average_invoice_count
    assert_equal Float, expected.class
  end

  def test_can_calculate_top_performing_merchants
    sales_engine = SalesEngine.from_csv({
      :items     => "data/items.csv",
      :merchants => "data/merchants.csv",
      :invoices => "data/invoices.csv"
    })
    sa = SalesAnalyst.new(sales_engine)
    expected = sa.top_merchants_by_invoice_count

    assert_equal 12, expected.count
    assert_equal Merchant, expected.first.class
  end

  def test_can_calculate_lowest_performing_merchants
    sales_engine = SalesEngine.from_csv({
      :items     => "data/items.csv",
      :merchants => "data/merchants.csv",
      :invoices => "data/invoices.csv"
    })
    sa = SalesAnalyst.new(sales_engine)
    expected = sa.bottom_merchants_by_invoice_count

    assert_equal 4, expected.count
    assert_equal Merchant, expected.first.class
  end

  def test_can_calculate_average_invoices_per_day
    sales_engine = SalesEngine.from_csv({
      :items     => "data/items.csv",
      :merchants => "data/merchants.csv",
      :invoices => "data/invoices.csv"
    })
    sa = SalesAnalyst.new(sales_engine)

    expected = sa.average_invoices_per_day
    assert_equal 712, expected
  end

  def test_can_calculate_count_of_invoices_for_each_week_day
    expected = sa.count_of_invoices_for_day_hash
    assert_equal Hash, expected.class
  end

  def test_can_calculate_average_invoices_per_day_standard_deviation
    skip
    expected = sa.average_invoices_per_day_standard_deviation
    # assert_equal (some number), expected
    assert_equal Float, expected.class
  end

  def test_can_calculate_one_std_dev_for_average_invoices_per_merchant
    skip
  end

  def test_can_calculate_one_std_dev_above_average_invoice_count_per_day
    skip
  end

  def test_can_calculate_which_days_of_the_week_see_the_most_sales
    skip
    sales_engine = SalesEngine.from_csv({
      :items     => "data/items.csv",
      :merchants => "data/merchants.csv",
      :invoices => "data/invoices.csv"
    })
    sa = SalesAnalyst.new(sales_engine)
    expected = sa.top_days_by_invoice_count

    assert_equal 1, expected.count
    assert_equal "Wednesday", expected.first
    assert_equal String, expected.first.class
  end
end
