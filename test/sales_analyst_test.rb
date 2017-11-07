require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa, :se
  def setup
    files = ({:invoices => "./test/fixture/invoice_fixture.csv",
      :items => "./test/fixture/item_fixture.csv",
      :merchants => "./test/fixture/merchant_fixture.csv",
      :invoice_items => "./test/fixture/invoice_item_fixture.csv",
      :transactions => "./test/fixture/transaction_fixture.csv",
      :customers => "./test/fixture/customer_fixture.csv"})
    @se = SalesEngine.from_csv(files)
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, setup
  end

  def test_it_averages_items_per_merchant
    assert_equal 0.39, setup.average_items_per_merchant
  end

  def test_item_count_per_merchants
    result = setup.counts_per_merchant(se.method(:find_merchant_items))

    assert_equal 18, result.count
  end

  def test_item_count_per_merchants_from_fixture
    result = setup.counts_per_merchant(se.method(:find_merchant_items))

    assert_instance_of Array, result
    assert_equal 18, result.count
  end

  def test_item_count_subtracts_from_average_items
    assert_equal 0.15, setup.variance_of_items[1]
  end

  def test_it_sums_array
    assert_equal 3.14, setup.sum_array
  end

  def test_it_std_deviates
    assert_equal 0.43, setup.average_items_per_merchant_standard_deviation
  end

  def test_merchant_list_with_high_item_count
    assert_equal 2, setup.merchants_with_high_item_count.count
  end

  def test_it_averages_item_price_for_merchant
    assert_instance_of BigDecimal, setup.average_item_price_for_merchant(12334185)
    assert_equal 0.1117e2, setup.average_item_price_for_merchant(12334185)
  end

  def test_average_average_price_per_merchant
    files = ({:items => "./data/items.csv",
              :merchants => "./data/merchants.csv",
              :invoices => "./data/invoices.csv",
              :invoice_items => "./test/fixture/invoice_item_fixture.csv",
              :transactions => "./test/fixture/transaction_fixture.csv",
              :customers => "./test/fixture/customer_fixture.csv"})
    se = SalesEngine.from_csv(files)
    s_a = SalesAnalyst.new(se)

    assert_instance_of BigDecimal, s_a.average_average_price_per_merchant
    assert_equal 0.35029e3, s_a.average_average_price_per_merchant
  end

  def test_find_average_item_price
    assert_equal 0.16293e3, setup.average_item_price
  end

  def test_golden_items
    assert_equal 1, setup.golden_items.count
  end

  def test_it_can_find_average_invoices_per_merchants
    assert_equal 3.22, setup.average_invoices_per_merchant
  end

  def test_it_can_find_invoice_average_per_standard_deviation
    assert_equal 0.43, setup.average_invoices_per_merchant_standard_deviation
  end

  def test_it_can_find_top_merchants_by_invoice_count
    files = ({:items => "./data/items.csv",
              :merchants => "./data/merchants.csv",
              :invoices => "./data/invoices.csv",
              :invoice_items => "./test/fixture/invoice_item_fixture.csv",
              :transactions => "./test/fixture/transaction_fixture.csv",
              :customers => "./test/fixture/customer_fixture.csv"})
    se = SalesEngine.from_csv(files)
    s_a = SalesAnalyst.new(se)

    assert_equal 12, s_a.top_merchants_by_invoice_count.count
  end

  def test_it_can_find_bottom_merchants_by_invoice_count
    files = ({:items => "./data/items.csv",
              :merchants => "./data/merchants.csv",
              :invoices => "./data/invoices.csv",
              :invoice_items => "./test/fixture/invoice_item_fixture.csv",
              :transactions => "./test/fixture/transaction_fixture.csv",
              :customers => "./test/fixture/customer_fixture.csv"})
    se = SalesEngine.from_csv(files)
    s_a = SalesAnalyst.new(se)

    assert_equal 4, s_a.bottom_merchants_by_invoice_count.count
  end

  def test_returns_day_of_week
    assert_equal 58, setup.day_created.count
  end

  def test_it_returns_count
    assert_equal 9, setup.day_count["Saturday"]
  end

  def test_it_can_find_top_days_by_invoice_count
    files = ({:items => "./data/items.csv",
              :merchants => "./data/merchants.csv",
              :invoices => "./data/invoices.csv",
              :invoice_items => "./test/fixture/invoice_item_fixture.csv",
              :transactions => "./test/fixture/transaction_fixture.csv",
              :customers => "./test/fixture/customer_fixture.csv"})
    se = SalesEngine.from_csv(files)
    s_a = SalesAnalyst.new(se)

    assert_equal ["Wednesday"], s_a.top_days_by_invoice_count
  end

  def test_invoices_have_a_status
    assert_equal 36.21, setup.invoice_status(:pending)
    assert_equal 58.62, setup.invoice_status(:shipped)
    assert_equal 5.17, setup.invoice_status(:returned)
  end

  def test_it_can_find_total_revenue_by_date
    assert_equal 0.528913e4, setup.total_revenue_by_date("2012-11-23")
  end

  def test_it_can_find_top_revenue_earners
    result = setup.top_revenue_earners(20)
    assert_equal "Shopin1901", result[0].name
  end

  def test_it_can_return_merchants_with_pending_invoices
    result = setup.merchants_with_pending_invoices

    assert_equal "Keckenbauer", result[0].name
  end

end
