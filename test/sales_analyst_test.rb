require './test/test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def setup
    se_elements = {
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv',
      customers: './data/customers.csv'
    }
    se = SalesEngine.from_csv(se_elements)

    @sa = se.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_has_repos
    assert_instance_of ItemsRepository, @sa.items
    assert_instance_of MerchantRepo, @sa.merchants
  end

  def test_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_average_item_price_for_merchant
    merchant_id = 12_334_159
    avg_price = @sa.average_item_price_for_merchant(merchant_id)
    assert_instance_of BigDecimal, avg_price
  end

  def test_average_average_price_per_merchant
    avg_avg = @sa.average_average_price_per_merchant
    assert_instance_of BigDecimal, avg_avg
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    assert_equal 52, @sa.merchants_with_high_item_count.length
  end

  def test_golden_items
    assert_equal 5, @sa.golden_items.length
  end

  def test_average_invoices_per_merchant
    assert_equal 10.49, @sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    assert_equal 3.29, @sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count
    assert_instance_of Merchant, @sa.top_merchants_by_invoice_count.first
    assert_equal 12, @sa.top_merchants_by_invoice_count.length
  end

  def test_bottom_merchants_by_invoice_count
    assert_instance_of Merchant, @sa.bottom_merchants_by_invoice_count.first
    assert_equal 4, @sa.bottom_merchants_by_invoice_count.length
  end

  def test_top_days_by_invoice_count
    assert_equal 1, @sa.top_days_by_invoice_count.length
    assert_equal 'Wednesday', @sa.top_days_by_invoice_count.first
  end

  def test_invoice_status
    assert_equal 29.55, @sa.invoice_status(:pending)

    assert_equal 56.95, @sa.invoice_status(:shipped)

    assert_equal 13.5, @sa.invoice_status(:returned)
  end

  def test_invoice_paid_in_full?
    assert_equal true, @sa.invoice_paid_in_full?(1)
    assert_equal false, @sa.invoice_paid_in_full?(203)
    assert_equal false, @sa.invoice_paid_in_full?(204)
  end

  def test_invoice_total
    @sa.invoice_total(1)

    assert_equal 21_067.77, @sa.invoice_total(1)
    assert_equal BigDecimal, @sa.invoice_total(1).class
  end

  def test_top_buyers
    actual = @sa.top_buyers(5)

    assert_equal 5, actual.length
    assert_equal 313, actual.first.id
    assert_equal 478, actual.last.id
  end

  def test_top_merchant
    actual = @sa.top_merchant_for_customer(100)

    assert_instance_of Merchant, actual
    assert_equal 12_336_753, actual.id
  end

  def test_one_time_buyers
    actual = @sa.one_time_buyers

    assert_equal 76, actual.length
    assert_instance_of Customer, actual.first
  end

  # def test_one_time_buyers_top_item
  #   actual = @sa.one_time_buyers_top_item
  #   assert_equal 263396463, actual
  #   assert_instance_of Item, actual
  # end

  def test_top_buyers_default
    actual = @sa.top_buyers

    assert_equal 20, actual.length
    assert_equal 313, actual.first.id
    assert_equal 250, actual.last.id
  end

  def test_best_invoice_by_revenue
    actual = @sa.best_invoice_by_revenue

    assert_equal 3394, actual.id
    assert_instance_of Invoice, actual
  end

  def test_best_invoice_by_quantity
    actual = @sa.best_invoice_by_quantity

    assert_equal 1281, actual.id
    assert_instance_of Invoice, actual
  end

  def test_items_bought_in_year
    customer_id = 400
    year_one = 2000
    expected_one = @sa.items_bought_in_year(customer_id, year_one)

    assert_equal 0, expected_one.length
    assert_instance_of Array, expected_one

    customer_id = 400
    year_two = 2002
    expected_two = @sa.items_bought_in_year(customer_id, year_two)

    assert_equal 2, expected_two.length
    assert_equal 263_549_742, expected_two.first.id
    assert_equal 'Necklace: V Tube', expected_two.first.name
    assert_equal Item, expected_two.first.class
  end

  def test_highest_volume_items
    customer_id = 200
    expected = @sa.highest_volume_items(customer_id)

    assert_equal 6, expected.length
    assert_equal 263_420_195, expected.first.id
    assert_equal 263_448_547, expected.last.id
    assert_instance_of Item, expected.first
  end

  def test_customers_with_unpaid_invoices
    expected = @sa.customers_with_unpaid_invoices

    assert_equal 786, expected.length
    assert_equal 1, expected.first.id
    assert_equal 999, expected.last.id
    assert_equal Customer, expected.first.class
  end
end
