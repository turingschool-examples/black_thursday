require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require 'time'

class SalesAnalystTest < MiniTest::Test

  def setup
    se = SalesEngine.from_csv({
    :items     => "./test/fixtures/items_fixture.csv",
    :merchants => "./test/fixtures/merchants_fixture.csv",
    :invoices => "./test/fixtures/invoices_fixture.csv",
    :transactions => "./test/fixtures/transactions_fixture.csv",
    :invoice_items => './test/fixtures/invoice_items_fixture.csv',
    :customers => "./test/fixtures/customers_fixture.csv"
    })

    se.items
    se.transactions
    se.invoice_items
    se.customers
    se.invoices
    se.merchants
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_can_find_average_items_per_merchant
    assert_equal 2.86, @sa.average_items_per_merchant
  end

  def test_it_adds_up_total_revenue_by_day
    date = Time.parse("2005-01-03")

    assert_equal 0.494478e4, @sa.total_revenue_by_date(date)
  end

  def test_top_revenue_earners
    @sa.top_revenue_earners(5)
  end

  def test_it_can_select_merchants_with_pending_invoices
    assert_instance_of Merchant, @sa.merchants_with_pending_invoices.first
    assert_equal 12, @sa.merchants_with_pending_invoices.count
  end

  def test_it_can_select_merchants_with_only_one_item
    assert_instance_of Merchant, @sa.merchants_with_only_one_item.first
    assert_equal 11, @sa.merchants_with_only_one_item.count
  end

  def test_it_can_find_the_total_revenue_for_a_merchant
    assert_instance_of BigDecimal, @sa.revenue_by_merchant(12334112)
    assert_equal 0, @sa.revenue_by_merchant(12334112)
    assert_equal 0.494478e4, @sa.revenue_by_merchant(12334105)
  end

  def test_find_golden_items
    assert_instance_of Item, @sa.golden_items.first
    assert_equal 13, @sa.golden_items.count
  end

  def test_average_average_price_per_merchant
    assert_instance_of BigDecimal, @sa.average_average_price_per_merchant
    assert_equal 0.3865e2, @sa.average_average_price_per_merchant
  end

  def test_average_item_price_for_merchant
    assert_instance_of BigDecimal, @sa.average_item_price_for_merchant(12334123)
    assert_equal 0.9545e2, @sa.average_item_price_for_merchant(12334123)
  end

  def test_merchants_with_high_item_count
    assert_instance_of Merchant, @sa.merchants_with_high_item_count.first
    assert_equal 4, @sa.merchants_with_high_item_count.count
    assert_equal 12334123, @sa.merchants_with_high_item_count[0].id
  end

  def test_it_can_find_top_days_by_invoice_count
    assert_equal ['Tuesday', 'Friday'], @sa.top_days_by_invoice_count
  end

  def test_it_can_sort_merchants_by_month_created
    assert_equal 12, @sa.merchant_by_month_created.keys.count
  end

  def test_it_can_tell_if_item_is_in_given_month
    merchant1 = @sa.se.merchants.find_by_id(12334183)
    merchant2 = @sa.se.merchants.find_by_id(12334132)

    refute @sa.item_in_month?(merchant2, "March")
    assert @sa.item_in_month?(merchant1, "January")
  end

  def test_it_can_find_merchants_with_one_item_in_month_they_were_created
    assert_equal 1, @sa.merchants_with_only_one_item_registered_in_month("October").count
  end

  def test_it_can_find_average_invoices_per_merchant
    assert_equal 2.19, @sa.average_invoices_per_merchant
  end

  def test_it_can_find_top_merchants_by_invoice_count
    assert_instance_of Merchant, @sa.top_merchants_by_invoice_count.first
    assert_equal 'jejum', @sa.top_merchants_by_invoice_count.first.name
  end

  def test_it_can_find_bottom_merchants_by_invoice_count
    assert @sa.bottom_merchants_by_invoice_count.empty?
  end

  def test_it_can_determine_invoice_status_percentages
    assert_equal 36.96, @sa.invoice_status(:pending)
    assert_equal 43.48, @sa.invoice_status(:shipped)
    assert_equal 19.57, @sa.invoice_status(:returned)
  end

  def test_it_can_select_only_paid_invoices_for_a_merchant
    invoice1 = @sa.se.invoices.find_by_id(1695)
    merchant = @sa.se.merchants.find_by_id(12334112)
    refute @sa.paid_invoices(merchant).include?(invoice1)
  end

  def test_it_can_find_the_most_sold_item
    expected = 'Knitted winter snood'
    item = @sa.most_sold_item_for_merchant(12334105).first

    assert_instance_of Item, item
    assert_equal expected, item.name
  end

  def test_it_can_find_the_most_best_sold_item
    expected = 'Knitted winter snood'
    item = @sa.best_item_for_merchant(12334105)

    assert_instance_of Item, item
    assert_equal expected, item.name
  end

end
