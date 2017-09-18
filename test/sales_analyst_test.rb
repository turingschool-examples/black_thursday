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
    SalesAnalyst.new(se)
  end

  def test_it_exists
    sa = setup

    assert_instance_of SalesAnalyst, sa
  end

  def test_it_can_find_average_items_per_merchant
    sa = setup

    assert_equal 2.86, sa.average_items_per_merchant
  end

  def test_it_can_find_the_invoices_on_each_day
    sa = setup

    assert_instance_of Hash, sa.number_of_invoices_by_day
    assert_equal 7, sa.number_of_invoices_by_day.count
    assert_equal sa.number_of_invoices_by_day, {"Monday"=>2, "Tuesday"=>11, "Wednesday"=>9, "Thursday"=>7, "Friday"=>8, "Saturday"=>4, "Sunday"=>5}
  end

  def test_it_adds_up_total_revenue_by_day
    sa = setup

    date = Time.parse("2005-01-03")

    assert_equal 0.494478e4, sa.total_revenue_by_date(date)
  end

  def test_top_revenue_earners
    sa = setup

    sa.top_revenue_earners(5)
  end

  def test_it_can_select_merchants_with_pending_invoices
    sa = setup

    assert_instance_of Merchant, sa.merchants_with_pending_invoices.first
    assert_equal 8, sa.merchants_with_pending_invoices.count
  end

end
