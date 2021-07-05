require_relative 'test_helper'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  def setup
    @se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :customers => "./data/customers.csv",
      :invoices  => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
      })
    @sa = @se.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_returns_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
    assert_equal Float, @sa.average_items_per_merchant.class
  end

  def test_it_returns_the_standard_deviation
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
    assert_equal Float, @sa.average_items_per_merchant_standard_deviation.class
  end

  def test_returns_merchants_more_than_one_standard_deviation_above_the_average_number_of_products_offered
   assert_equal 52, @sa.merchants_with_high_item_count.length
   assert_equal Merchant, @sa.merchants_with_high_item_count.first.class
  end

  def test_returns_the_average_item_price_for_the_given_merchant
    average_item_price = @sa.average_item_price_for_merchant(12334105)

    assert_equal 16.66, average_item_price
    assert_equal BigDecimal, average_item_price.class
  end

  def test_it_returns_the_average_price_for_all_merchants
   assert_equal 350.29, @sa.average_average_price_per_merchant

   assert_equal BigDecimal, @sa.average_average_price_per_merchant.class
  end

  def test_returns_items_that_are_two_standard_deviations_above_the_average_price
    assert_equal 5, @sa.golden_items.length
    assert_equal Item, @sa.golden_items.first.class
  end

  def test_it_returns_average_number_of_invoices_per_merchant
    assert_equal 10.49, @sa.average_invoices_per_merchant
    assert_equal Float, @sa.average_invoices_per_merchant.class
  end

  def test_it_returns_the_standard_deviation
    assert_equal 3.29, @sa.average_invoices_per_merchant_standard_deviation
    assert_equal Float, @sa.average_invoices_per_merchant_standard_deviation.class
  end

  def test_it_returns_top_merchants_by_invoice_count
    assert_equal 12, @sa.top_merchants_by_invoice_count.length
    assert_equal Merchant, @sa.top_merchants_by_invoice_count.first.class
  end

  def test_it_returns_bottom_merchants_by_invoice_count
    assert_equal 4, @sa.bottom_merchants_by_invoice_count.length
    assert_equal Merchant, @sa.bottom_merchants_by_invoice_count.first.class
  end

  def test_returns_days_with_an_invoice_count_more_than_one_standard_deviation_above_the_mean
    assert_equal 1, @sa.top_days_by_invoice_count.length
    assert_equal "Wednesday", @sa.top_days_by_invoice_count.first
    assert_equal String, @sa.top_days_by_invoice_count.first.class
  end

  def test_returns_the_percentage_of_invoices_with_given_status
    assert_equal 29.55, @sa.invoice_status(:pending)
    assert_equal 56.95, @sa.invoice_status(:shipped)
    assert_equal 13.5, @sa.invoice_status(:returned)
  end

  def test_it_returns_true_if_the_invoice_is_paid_in_full
    assert_equal true, @sa.invoice_paid_in_full?(1)
    assert_equal true, @sa.invoice_paid_in_full?(200)
    assert_equal false, @sa.invoice_paid_in_full?(203)
    assert_equal false, @sa.invoice_paid_in_full?(204)
  end

  def test_it_returns_the_total_dollar_amount_if_the_invoice_is_paid_in_full
    invoice_total = @sa.invoice_total(1)

    assert_equal 21067.77, invoice_total
    assert_equal BigDecimal, invoice_total.class
  end

  def test_it_returns_the_top_x_customers_that_spent_the_most_money
    customers = @sa.top_buyers(5)

    assert_equal 5, customers.length
    assert_equal 313, customers.first.id
    assert_equal 478, customers.last.id

    assert_equal Customer, customers.last.class
  end

  def test_it_returns_top_20_customers_if_no_argument_given
    top_buyers = @sa.top_buyers

    assert_equal 20, top_buyers.length
    assert_equal 313, top_buyers.first.id
    assert_equal 250, top_buyers.last.id

    assert_equal Customer, top_buyers.last.class
  end

  def test_it_returns_top_merchant_given_customer_id
    merchant = @sa.top_merchant_for_customer(100)

    assert_equal Merchant, merchant.class
    assert_equal 12336753, merchant.id
  end

  def test_one_time_buyers_returns_customers_with_only_one_invoice
    customers = @sa.one_time_buyers

    assert_equal 76, customers.length
    assert_equal Customer, customers.first.class
  end

  def test_it_returns_item_bought_by_one_time_buyers_in_the_highest_quantity
    highest_selling_item = @sa.one_time_buyers_top_item

    assert_equal 263396463, highest_selling_item.id
    assert_equal Item, highest_selling_item.class
  end

  def test_it_returns_the_items_which_the_given_customer_bought_in_the_given_year
    customer_id = 400
    year = 2000
    items = @sa.items_bought_in_year(customer_id, year)

    assert_equal 0, items.length
    assert_equal Array, items.class

    customer_id = 400
    year = 2002
    items = @sa.items_bought_in_year(customer_id, year)

    assert_equal 2, items.length
    assert_equal 263549742, items.first.id
    assert_equal "Necklace: V Tube", items.first.name
    assert_equal Item, items.first.class
  end

  def test_highest_volume_items_returns_an_array_of_the_item_purchased_the_most_times_by_a_customer
    items = @sa.highest_volume_items(200)

    assert_equal 6, items.length
    assert_equal 263420195, items.first.id
    assert_equal 263448547, items.last.id
    assert_equal Item, items.first.class
  end

  def test_customers_with_unpaid_invoices_returns_customers_with_unpaid_invoices
    customers = @sa.customers_with_unpaid_invoices

    assert_equal 786, customers.length
    assert_equal 1, customers.first.id
    assert_equal 999, customers.last.id
    assert_equal Customer, customers.first.class
  end

  def test_best_invoice_by_revenue_returns_the_invoice_with_the_highest_dollar_amount
    invoice = @sa.best_invoice_by_revenue

    assert_equal 3394, invoice.id
    assert_equal Invoice, invoice.class
  end

  def test_best_invoice_by_quantity_returns_the_invoice_with_the_highest_item_count
    invoice = @sa.best_invoice_by_quantity

    assert_equal 1281, invoice.id
    assert_equal Invoice, invoice.class
  end

end
