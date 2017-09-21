require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/sales_analyst"
require "./lib/item_repository"
require "./lib/merchant_repository"
require "./lib/merchant"
require "./lib/item"


class SalesAnalystTest < Minitest::Test

  attr_reader :sa

  def setup
    csv_hash = {
      :items     => "./test/test_fixtures/items_medium.csv",
      :merchants => "./test/test_fixtures/merchants_medium.csv",
      :invoices => ".//test/test_fixtures/invoices_medium.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./test/test_fixtures/transactions_medium.csv",
      :customers => "./test/test_fixtures/customers_medium.csv"
    }
    sales_engine = SalesEngine.from_csv(csv_hash)
    @sa = SalesAnalyst.new(sales_engine)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_averages_items_per_merchant
    assert_equal 2.02, sa.average_items_per_merchant
  end

  def test_it_takes_a_standard_deviation
    assert_equal 2.44, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_finds_merchants_with_high_item_count
    assert_instance_of Array, sa.merchants_with_high_item_count
    assert_instance_of Merchant, sa.merchants_with_high_item_count[0]
  end

  def test_it_finds_average_item_price_for_merchant
    assert_equal BigDecimal.new(10.25, 4), sa.average_item_price_for_merchant(12334185)
  end

  def test_it_sums_averages_across_merchants_and_averages
    assert_equal BigDecimal.new(241.9, 4), sa.average_average_price_per_merchant
  end

  def test_it_returns_golden_items
    assert_instance_of Array, sa.golden_items
    assert_instance_of Item, sa.golden_items[0]
  end

  def test_it_returns_top_merchants_by_invoice
    assert_instance_of Array, sa.top_merchants_by_invoice_count
    assert_instance_of Merchant, sa.top_merchants_by_invoice_count[0]
  end

  def test_it_finds_percent_status
    assert_equal 29.67, sa.invoice_status(:pending)
    assert_equal 56.95, sa.invoice_status(:shipped)
    assert_equal 13.41, sa.invoice_status(:returned)
  end

  def test_it_checks_if_invoice_is_paid_in_full
    assert sa.sales_engine.invoices.all[1].is_paid_in_full?
    refute sa.sales_engine.invoices.all[0].is_paid_in_full?
  end

  def test_can_check_if_merchant_is_pending
    assert sa.is_pending?(12334149)
    refute sa.is_pending?(12334105)
  end

  def test_it_finds_merchants_with_pending_invoices
    assert_instance_of Array, sa.merchants_with_pending_invoices
    assert_instance_of Merchant, sa.merchants_with_pending_invoices[0]
  end

  def test_finds_merchants_with_only_one_item
    assert_instance_of Array, sa.merchants_with_only_one_item
    assert_instance_of Merchant, sa.merchants_with_only_one_item[0]
    assert_equal 1, sa.merchants_with_only_one_item[0].items.count
  end

  def test_it_returns_bottom_merchants_by_invoice
    assert_instance_of Array, sa.bottom_merchants_by_invoice_count

    assert_instance_of Merchant, sa.bottom_merchants_by_invoice_count[0]
  end

  def test_it_returns_top_days_by_invoice
    assert_instance_of Array, sa.top_merchants_by_invoice_count
    assert_instance_of Merchant, sa.top_merchants_by_invoice_count[0]
  end

  def test_it_finds_top_days_by_invoice_count
    assert_equal ["Wednesday"], sa.top_days_by_invoice_count
  end

  def test_it_finds_total_revenue_by_date
    assert_equal 528913.0, sa.total_revenue_by_date(Time.parse("2012-11-23"))
  end

  def test_it_returns_top_merchants_by_revenue
    assert_instance_of Merchant, sa.top_revenue_earners(5)[0]
  end

  def test_it_finds_most_sold_item_for_merchant

  assert_equal ["."], sa.most_sold_item_for_merchant(12334768)
  end

  def test_it_finds_best_item_for_merchant
  assert_instance_of Item, sa.best_item_for_merchant(12334189)
  end

end
