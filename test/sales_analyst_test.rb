require './test/test_helper.rb'
require './lib/sales_analyst.rb'
require 'pry'

class SalesAnalystTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv(
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices_test.csv',
      customers: './data/customers.csv',
      invoice_items: './data/invoice_items_test.csv',
      transactions: './data/transactions_test.csv'
    )
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_can_find_the_items_per_merchant
    assert_equal 1, @sa.items_per_merchant[0]
    assert_equal 6, @sa.items_per_merchant[1]
  end

  def test_analyst_can_check_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_can_find_the_standard_deviation_for_average_items_per_merchant
    assert_equal 3.26, @sa.items_per_merchant_standard_dev
  end

  def test_it_can_find_merchants_offering_high_item_count
    assert_equal 52, @sa.merchants_with_high_item_count.length
    assert_instance_of Merchant, @sa.merchants_with_high_item_count.first
  end

  def test_it_can_find_average_item_price_per_merchant
    assert_equal 16.66, @sa.average_item_price_for_merchant(12334105)
  end

  def test_it_can_find_average_average_item_price_per_merchant
    assert_equal 350.29, @sa.average_average_price_per_merchant
  end

  def test_it_can_find_the_price_standard_deviation
    assert_equal 2900.99, @sa.item_price_standard_deviation
  end

  def test_it_can_find_all_golden_items
    assert_equal 5, @sa.golden_items.length
    assert_equal Item, @sa.golden_items.first.class
  end

  def test_it_can_find_the_invoices_per_merchant
    assert_equal 1, @sa.invoices_per_merchant[0]
    assert_equal 1, @sa.invoices_per_merchant[1]
  end

  def test_it_can_find_the_average_invoices_per_merchant
    assert_equal 1.13, @sa.average_invoices_per_merchant
  end

  def test_it_can_find_the_average_invoices_per_merchant_standard_devaition
    assert_equal 0.34, @sa.invoices_per_merchant_stand_dev
  end

  def test_it_can_find_top_performing_merchants
    assert_equal 12, @sa.top_merchants_by_invoice_count.count
    assert_instance_of Merchant, @sa.top_merchants_by_invoice_count[0]
  end

  def test_it_can_find_bottom_performing_merchants
    assert_equal 0, @sa.bottom_merchants_by_invoice_count.count
  end

  def test_it_can_find_top_days_of_the_week
    assert_equal 1, @sa.top_days_by_invoice_count.count
    assert_equal 'Friday', @sa.top_days_by_invoice_count.first
  end

  def test_it_can_find_the_percent_of_invoices_at_each_status
    assert_equal 28.71, @sa.invoice_status(:pending)
    assert_equal 63.37, @sa.invoice_status(:shipped)
    assert_equal 7.92, @sa.invoice_status(:returned)
  end

  def test_it_can_check_if_an_invoice_is_fully_paid
    assert @sa.invoice_paid_in_full?(46)
    assert @sa.invoice_paid_in_full?(2179)
    refute @sa.invoice_paid_in_full?(1752)
  end

  def test_it_can_return_the_amount_for_any_invoice
    assert_equal 21067.77, @sa.invoice_total(1)
  end

  def test_it_can_find_the_total_revenue_by_date
    date = Time.parse('2005-11-11')
    assert_equal 0.0, @sa.total_revenue_by_date(date)
    assert_instance_of BigDecimal, @sa.total_revenue_by_date(date)
  end

  def test_it_can_find_top_x_revenue_earners
    top_earners = @sa.top_revenue_earners(3)
    assert_equal 3, top_earners.length
    assert_equal Merchant, top_earners.first.class
    assert_equal 12335150, top_earners.first.id
    assert_equal 12335417, top_earners.last.id
  end

  def test_it_can_find_revenue_for_one_merchant
    assert_equal 22496.84, @sa.revenue_by_merchant(12335150)
  end

  def test_it_can_find_merchants_with_pending_invoices
    assert_equal 86, @sa.merchants_with_pending_invoices.length
    assert_equal Merchant, @sa.merchants_with_pending_invoices.first.class
  end

  def test_it_can_find_merchants_with_only_one_item
    assert_equal Array, @sa.merchants_with_only_one_item.class
    assert_equal 243, @sa.merchants_with_only_one_item.length
    assert_equal Merchant, @sa.merchants_with_only_one_item.first.class
  end

  def test_it_can_find_merchants_with_one_invoice_in_given_month
    assert_equal 21, @sa.merchants_with_only_one_item_registered_in_month('March').length
    assert_equal Merchant, @sa.merchants_with_only_one_item_registered_in_month('March').first.class
  end

  def test_it_can_find_most_sold_item_for_merchant
    se = SalesEngine.from_csv(
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      customers: './data/customers.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv'
    )
    sa = SalesAnalyst.new(se)
    assert_equal 263524984, sa.most_sold_item_for_merchant(12334189).first.id
    assert_equal 'Adult Princess Leia Hat', sa.most_sold_item_for_merchant(12334189).first.name
    assert_instance_of Item, sa.most_sold_item_for_merchant(12334189).first
    assert_equal 263549386, sa.most_sold_item_for_merchant(12334768).first.id
    assert_equal 4, sa.most_sold_item_for_merchant(12337105).length
  end

  def test_it_can_find_successful_invoice_items_per_merchant_id
    se = SalesEngine.from_csv(
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      customers: './data/customers.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv'
    )
    sa = SalesAnalyst.new(se)
    merchant_id = 12334189
    assert_equal 16, sa.successful_invoice_items_per_merchant_id(merchant_id)
                       .count
    assert_equal InvoiceItem, sa.successful_invoice_items_per_merchant_id(merchant_id).first.class
  end

  def test_it_can_take_array_of_invoice_items_and_group_by_id_with_total_price
    se = SalesEngine.from_csv(
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      customers: './data/customers.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv'
    )
    sa = SalesAnalyst.new(se)
    array = sa.successful_invoice_items_per_merchant_id(12334269)
    assert_equal 13, sa.invoice_items_with_total_price(array).keys.count
    assert_equal Hash, sa.invoice_items_with_total_price(array).class
    assert_equal BigDecimal, sa.invoice_items_with_total_price(array)
                               .values.first.class
  end

  def test_it_can_find_high_item_from_hash
    hash = { 263516130 => 20, 263463003 => 40 }
    item = @sa.se.items.find_by_id(263463003)
    assert_equal item, @sa.high_item_from_item_ids_with_values(hash).first
  end

  def test_it_can_find_best_item_for_merchant
    se = SalesEngine.from_csv(
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      customers: './data/customers.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv'
    )
    sa = SalesAnalyst.new(se)
    assert_equal 263516130, sa.best_item_for_merchant(12334189).id
    assert_equal 263463003, sa.best_item_for_merchant(12337105).id
  end

  def test_it_can_change_nil_values_to_zero
    hash = { student: 'Lucas', feeling: 'Tired', energy: nil }
    new_hash = { student: 'Lucas', feeling: 'Tired', energy: 0 }
    assert_equal new_hash, @sa.change_nil_values_to_zero(hash)
  end

  def test_it_can_rank_merchants_by_revenue
    assert_equal Merchant, @sa.merchants_ranked_by_revenue.first.class
    assert_equal 12335150, @sa.merchants_ranked_by_revenue.first.id
    assert_equal 12334343, @sa.merchants_ranked_by_revenue.last.id
  end
end
