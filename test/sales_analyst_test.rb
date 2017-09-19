require_relative 'test_helper'
require_relative '../lib/sales_analyst'

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

  def test_it_can_find_the_invoices_on_each_day
    assert_instance_of Hash, @sa.number_of_invoices_by_day
    assert_equal 7, @sa.number_of_invoices_by_day.count
    assert_equal @sa.number_of_invoices_by_day, {"Monday"=>2, "Tuesday"=>11, "Wednesday"=>9, "Thursday"=>7, "Friday"=>8, "Saturday"=>4, "Sunday"=>5}
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
    assert_equal 0.494478e4, @sa.revenue_by_merchant(12334112)
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
    assert_equal ['Tuesday'], @sa.top_days_by_invoice_count
  end

  def test_it_can_find_the_most_sold_item
    assert_instance_of Item, @sa.most_sold_item_for_merchant(12334123)
    assert_equal 'Adidas Breitner Super Fußballschuh', @sa.most_sold_item_for_merchant(12334123).name
  end

  def test_it_can_sort_merchants_by_month_created
    assert_equal 12, @sa.merchant_by_month_created.keys.count
  end

  def test_it_can_tell_if_invoice_is_in_given_month
    merchant1 = @sa.se.merchants.find_by_id(12334183)
    merchant2 = @sa.se.merchants.find_by_id(12334132)

    refute @sa.invoice_in_month?(merchant2, "March")
    assert @sa.invoice_in_month?(merchant1, "October")
  end

  def test_it_can_find_merchants_with_one_invoice_in_month_they_were_created
    assert_equal 0, @sa.merchants_with_only_one_item_registered_in_month("October").count

  end

end
