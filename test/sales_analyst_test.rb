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
    assert_equal 1.0, setup.average_items_per_merchant
  end

  def test_item_count_per_merchants
    result = setup.counts_per_merchant(se.method(:find_merchant_items))

    assert_equal 7, result.count
  end

  def test_item_count_per_merchants_from_fixture
    result = setup.counts_per_merchant(se.method(:find_merchant_items))

    assert_instance_of Array, result
    assert_equal 7, result.count
  end

  def test_item_count_subtracts_from_average_items
    assert_equal 1.0, setup.variance_of_items[1]
  end

  def test_it_sums_array
    assert_equal 5.0, setup.sum_array
  end

  def test_it_std_deviates
    assert_equal 0.91, setup.average_items_per_merchant_standard_deviation
  end

  def test_merchant_list_with_high_item_count
    files = ({:items => "./data/items.csv",
              :merchants => "./data/merchants.csv",
              :invoices => "./data/invoices.csv",
              :invoice_items => "./test/fixture/invoice_item_fixture.csv",
              :transactions => "./test/fixture/transaction_fixture.csv",
              :customers => "./test/fixture/customer_fixture.csv"})
    se = SalesEngine.from_csv(files)
    s_a = SalesAnalyst.new(se)
    assert_equal 52, s_a.merchants_with_high_item_count.count
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
    files = ({:items => "./data/items.csv",
              :merchants => "./data/merchants.csv",
              :invoices => "./data/invoices.csv",
              :invoice_items => "./test/fixture/invoice_item_fixture.csv",
              :transactions => "./test/fixture/transaction_fixture.csv",
              :customers => "./test/fixture/customer_fixture.csv"})
    se = SalesEngine.from_csv(files)
    s_a = SalesAnalyst.new(se)

    assert_equal 0.25106e3, s_a.average_item_price
  end

  def test_golden_items
    files = ({:items => "./data/items.csv",
              :merchants => "./data/merchants.csv",
              :invoices => "./data/invoices.csv",
              :invoice_items => "./test/fixture/invoice_item_fixture.csv",
              :transactions => "./test/fixture/transaction_fixture.csv",
              :customers => "./test/fixture/customer_fixture.csv"})
    se = SalesEngine.from_csv(files)
    s_a = SalesAnalyst.new(se)

    assert_equal 5, s_a.golden_items.count
  end

  def test_it_can_find_average_invoices_per_merchants
    assert_equal 8.29, setup.average_invoices_per_merchant
  end

  def test_it_can_find_invoice_average_per_standard_deviation
    assert_equal 0.49, setup.average_invoices_per_merchant_standard_deviation
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
    files = ({:items => "./data/items.csv",
              :merchants => "./data/merchants.csv",
              :invoices =>"./test/fixture/invoice_fixture.csv",
              :invoice_items => "./test/fixture/invoice_item_fixture.csv",
              :transactions => "./test/fixture/transaction_fixture.csv",
              :customers => "./test/fixture/customer_fixture.csv"})
    se = SalesEngine.from_csv(files)
    s_a = SalesAnalyst.new(se)

    assert_equal 58, s_a.day_created.count
  end

  def test_it_returns_count
    files = ({:items => "./data/items.csv",
              :merchants => "./data/merchants.csv",
              :invoices =>"./test/fixture/invoice_fixture.csv",
              :invoice_items => "./test/fixture/invoice_item_fixture.csv",
              :transactions => "./test/fixture/transaction_fixture.csv",
              :customers => "./test/fixture/customer_fixture.csv"})
    se = SalesEngine.from_csv(files)
    s_a = SalesAnalyst.new(se)

    assert_equal 9, s_a.day_count["Saturday"]
  end


  def test_it_can_find_top_days_by_invoice_count
    files = ({:items => "./data/items.csv",
              :merchants => "./data/merchants.csv",
              :invoices =>"./test/fixture/invoice_fixture.csv",
              :invoice_items => "./test/fixture/invoice_item_fixture.csv",
              :transactions => "./test/fixture/transaction_fixture.csv",
              :customers => "./test/fixture/customer_fixture.csv"})
    se = SalesEngine.from_csv(files)
    s_a = SalesAnalyst.new(se)

    assert_equal ["Friday"], s_a.top_days_by_invoice_count

  end

end
