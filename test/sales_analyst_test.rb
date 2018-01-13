require_relative 'test_helper'
require_relative '../lib/sales_analyst'


class SalesAnalystTest < Minitest::Test

  attr_reader :sales_analyst

  def setup

    @se = SalesEngine.new({
      :items         => "./test/fixtures/items_sample.csv",
      :merchants     => "./test/fixtures/merchants_sample.csv",
      :invoices      => "./test/fixtures/invoices_sample.csv",
      :invoice_items => "./test/fixtures/invoice_items_sample.csv",
      :customers     => "./test/fixtures/customers_sample.csv",
      :transactions  => "./test/fixtures/transactions_sample.csv"
    })
    @sales_analyst = SalesAnalyst.new(@se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_it_returns_average
    assert_equal 3.57, sales_analyst.average_items_per_merchant
    refute_equal "3.57", sales_analyst.average_items_per_merchant
    refute_equal 0.43, sales_analyst.average_items_per_merchant
  end

  def test_it_returns_item_price_standard_deviation
    assert_equal 235.37, sales_analyst.item_price_standard_deviation
    refute_equal "235.37", sales_analyst.item_price_standard_deviation
    refute_equal 300, sales_analyst.item_price_standard_deviation
  end

  def test_it_returns_standard_deviation
    assert_equal 3.27, sales_analyst.average_items_per_merchant_standard_deviation
    refute_equal 3.20, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_returns_array_of_item_totals_for_merchants
    assert_equal 7, sales_analyst.number_of_items_per_merchant.count
    refute_equal 4, sales_analyst.number_of_items_per_merchant.count
  end

  def test_it_returns_merchants_with_highest_item_count
    assert_equal 1, sales_analyst.merchants_with_high_item_count.count
    refute_equal 10, sales_analyst.merchants_with_high_item_count.count
  end

  def test_it_returns_top_merchants_by_invoice_count
    assert_equal 0, sales_analyst.top_merchants_by_invoice_count.count
    refute_equal 3, sales_analyst.top_merchants_by_invoice_count.count
  end

  def test_it_returns_bottom_merchants_by_invoice_count
    assert_equal 0, sales_analyst.bottom_merchants_by_invoice_count.count
    refute_equal 3, sales_analyst.bottom_merchants_by_invoice_count.count
  end

  def test_it_returns_average_price_of_merchants_items
    assert_equal 0.2999e2, sales_analyst.average_item_price_for_merchant(12334105)
  end

  def test_it_returns_average_invoices_per_merchant
    assert_equal 2.71, sales_analyst.average_invoices_per_merchant
    refute_equal 2.00, sales_analyst.average_invoices_per_merchant
  end

  def test_it_returns_standard_deviation_for_invoices
    assert_equal 2.68, sales_analyst.average_invoices_per_merchant_standard_deviation
    refute_equal 3.20, sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_it_returns_status_of_invoices_as_percentage
    assert_equal 15.79, sales_analyst.invoice_status(:pending)
    assert_equal 63.16 , sales_analyst.invoice_status(:shipped)
    assert_equal 21.05, sales_analyst.invoice_status(:returned)
  end

  def test_it_returns_group_invoices_by_day
    assert_equal 7, sales_analyst.group_invoices_by_day.count
  end

  def test_it_returns_average_invoices_per_day
    assert_equal 2, sales_analyst.average_invoices_per_day
  end

  def test_it_returns_average_invoices_per_day_standard_deviation
    assert_equal 2.24, sales_analyst.average_invoices_per_day_standard_deviation
    refute_equal 2.63, sales_analyst.average_invoices_per_day_standard_deviation
  end

  def test_it_returns_top_days_by_invoice_count
    assert_equal ["Friday", "Tuesday"], sales_analyst.top_days_by_invoice_count
  end

  def test_it_returns_group_by_status
    assert_equal 3, sales_analyst.group_by_status.count
    refute_equal "2", sales_analyst.group_by_status.count
    refute_equal 7, sales_analyst.group_by_status.count
  end

  def test_it_returns_array_of_invoices_per_day
    assert_equal [2, 6, 6, 1, 2, 1, 1], sales_analyst.invoices_per_day
    refute_equal [], sales_analyst.invoices_per_day
    refute_equal [5, 3, 3, 1, 1, 1, 1], sales_analyst.invoices_per_day
  end

  def test_average_invoices_per_day_standard_deviation
    assert_equal 2.68, sales_analyst.average_invoices_per_merchant_standard_deviation
    refute_equal 1.29, sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_it_returns_total_revenue_by_date
    assert_equal 0.2023211e5, sales_analyst.total_revenue_by_date(Time.parse('2009-12-09'))
    refute_equal 'hopefully no strings', sales_analyst.total_revenue_by_date(Time.parse('2009-12-09'))
  end

  def test_it_grabs_invoice_by_date
    invoice = sales_analyst.grab_invoice_by_date(Time.parse('2009-12-09'))

    assert_equal 3, invoice.first.id
    assert_equal (Time.parse('2009-12-09')).to_i, invoice.first.created_at.to_i
  end

  def test_it_grabs_invoice_by_date
    invoice_items = sales_analyst.grab_invoice_items_by_invoice_date(Time.parse('2009-12-09'))

    assert invoice_items.all? { |invoice_item| invoice_item.class == InvoiceItem }
  end

  def test_it_returns_top_earners
    assert sales_analyst.top_revenue_earners.all? { |merch| merch.class == Merchant }
    assert_equal 7, sales_analyst.top_revenue_earners.count
    assert_equal 12334141, sales_analyst.top_revenue_earners.first.id
  end

  def test_it_grabs_merchants_with_only_one_item
    assert_equal 3, sales_analyst.merchants_with_only_one_item.count
    refute_equal 1, sales_analyst.merchants_with_only_one_item.count
    assert sales_analyst.merchants_with_only_one_item.all? { |merch| merch.class == Merchant }
  end

  def test_it_grabs_merchants_with_pending_invoices
    assert sales_analyst.merchants_with_pending_invoices.all? do |merchant|
       merchant.class == Merchant
    end
    assert_equal 7, sales_analyst.merchants_with_pending_invoices.count
    assert_equal 12334141, sales_analyst.merchants_with_pending_invoices.first.id
  end

  def test_it_returns_merchants_revenue
    assert_equal 73407, sales_analyst.revenue_by_merchant(12334141).to_i
    refute_equal 3244244233, sales_analyst.revenue_by_merchant(12334141)
  end

  def test_it_grabs_merchants_ranked_by_revenue
    assert_equal 7, sales_analyst.merchants_ranked_by_revenue.count
  end

  def test_it_grabs_merchants_with_only_one_item_registered_in_month
    assert_equal 2, sales_analyst.merchants_with_only_one_item_registered_in_month("June").count
  end

  def test_it_grab_invoices_from_merchants
    paid_invoices = sales_analyst.grab_paid_invoice_items_from_merchants(12334141)

    assert_equal 14, paid_invoices.count
    assert_equal 14, paid_invoices.count
    assert paid_invoices.all? { |invoice| invoice.class == InvoiceItem }
    refute paid_invoices.all? { |invoice| invoice.class == Invoice }
  end

  def test_it_groups_items_to_invoice_attributes
    grouped_attributes = sales_analyst.group_items_to_invoice_attributes(12334141)

    refute_equal 10, grouped_attributes.count
    assert_equal 5, grouped_attributes.count
    assert_equal [263418403, [7, 0.5384e3]], grouped_attributes.first
    assert_instance_of Hash, grouped_attributes
    refute_instance_of Array, grouped_attributes
  end

  def test_it_grabs_most_sold_items
    most_sold = sales_analyst.grab_most_sold_items(12334141)

    assert_equal 1, most_sold.count
    assert_equal 263415463, most_sold.first
    refute_equal 22335415463, most_sold.first
  end

  def test_it_grabs_most_sold_item_for_merchant
    most_sold = sales_analyst.most_sold_item_for_merchant(12334141)

    assert_equal 1, most_sold.count
  end

  def test_it_groups_items_to_revenue
    grouped_revenue = sales_analyst.group_items_to_revenue(12334141)
    actual_grouped_revenue = {263418403=>0.37688e4,
                              263501136=>0.358218e4,
                              263426891=>0.22129e4,
                              263540674=>0.493842e4,
                              263415463=>0.74005e4
                            }

    assert_equal actual_grouped_revenue, grouped_revenue
  end

  def test_it_returns_top_item_by_revenue_id
    top_item = sales_analyst.top_item_by_revenue_id(12334141)

    assert_equal 10, top_item.count
    refute_equal 3, top_item.count
    assert_equal [263415463, 0.74005e4, 263540674, 0.493842e4], top_item[0..3]
    refute_equal [263234463, 0.74044e4, 263123674, 0.493232e4], top_item[0..3]
  end

end
