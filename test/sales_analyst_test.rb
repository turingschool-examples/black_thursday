require './test/test_helper'

class SalesAnalystTest < Minitest::Test
  def setup
    item_path          = "./data/items.csv"
    merchant_path      = "./data/merchants.csv"
    invoice_path       = "./data/invoices.csv"
    invoice_item_path  = "./data/invoice_items.csv"
    customer_path      = "./data/customers.csv"
    transaction_path   = "./data/transactions.csv"
    arguments = {
                  :items     => item_path,
                  :merchants => merchant_path,
                  :invoices  => invoice_path,
                  :invoice_items => invoice_item_path,
                  :customers     => customer_path,
                  :transactions => transaction_path
                }
    @se = SalesEngine.from_csv(arguments)
    @sales_analyst = @se.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_has_parent
    assert_instance_of SalesEngine, @sales_analyst.parent
  end

  def test_it_can_return_average_items_per_merchant
    assert_equal 2.88, @sales_analyst.average_items_per_merchant
  end

  def test_all_items_count_helper
    collection = @se.items
    assert_equal 1367, @sales_analyst.all_collection_count(collection)
  end

  def test_all_merchants_count_helper
    collection = @se.merchants
    assert_equal 475, @sales_analyst.all_collection_count(collection)
  end

  def test_average_items_per_merchant_standard_deviation
    assert_equal 3.26, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_display_merchants_with_high_item_count
    assert_equal 52, @sales_analyst.merchants_with_high_item_count.length
  end

  def test_generate_merchant_ids_helper
    assert_equal 475, @sales_analyst.generate_merchant_ids.length
  end

  def test_it_can_returns_the_average_item_price_for_the_given_merchant
    assert_equal 16.66, @sales_analyst.average_item_price_for_merchant(12334105)
  end

  def test_it_returns_the_average_price_for_all_merchants
    assert_equal 350.29, @sales_analyst.average_average_price_per_merchant
  end

  def test_returns_items_that_are_two_standard_deviations_above_the_average_price
    assert_equal 5, @sales_analyst.golden_items.length
  end

  def test_items_count_per_merchant_helper
    assert_equal 475, @sales_analyst.items_count_per_merchant.length
  end

  def test_all_items_minus_one_helper
    array = [1, 2, 3, 4, 5]
    assert_equal 4, @sales_analyst.all_elements_minus_one(array)
    amount_2 = (1..475).to_a
    assert_equal 474, @sales_analyst.all_elements_minus_one(amount_2)
  end

  def test_standard_deviation_calculation_helper
    total = 2
    collection_length = 2
    assert_equal 1, @sales_analyst.standard_deviaton_calculation(total, collection_length)
  end

  def test_mean_prices_per_merchant_helper
    assert_equal 475, @sales_analyst.mean_prices_per_merchant.length
  end

  def test_total_helper
    set = [3, 4, 5]
    assert_equal 2, @sales_analyst.total(set, 4)
  end

  def test_it_returns_average_number_of_invoices_per_merchant
    assert_equal 10.49, @sales_analyst.average_invoices_per_merchant
  end

  def test_it_returns_average_invoices_per_merchant_standard_deviation
    assert_equal 3.29, @sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_invoice_count_per_merchant_helper
    assert_equal 475, @sales_analyst.invoice_count_per_merchant.length
  end

  def test_top_merchants_by_invoice_count
    assert_equal 12, @sales_analyst.top_merchants_by_invoice_count.length
  end

  def test_bottom_merchants_by_invoice_count
    assert_equal 4, @sales_analyst.bottom_merchants_by_invoice_count.length
  end

  def test_average_invoices_per_day_helper
    assert_equal 712.14, @sales_analyst.average_invoices_per_day
  end

  def test_invoices_by_days_helper
    keys = ["Saturday", "Friday", "Wednesday", "Monday", "Sunday", "Tuesday", "Thursday"]
    assert_equal 7, @sales_analyst.invoices_by_days.length
    assert_equal keys, @sales_analyst.invoices_by_days.keys
  end

  def test_invoices_count_per_day_helper
    assert_equal 7, @sales_analyst.invoices_count_per_day.length
  end

  def test_top_days_by_invoice_count
    assert_equal 1, @sales_analyst.top_days_by_invoice_count.length
    assert_equal "Wednesday", @sales_analyst.top_days_by_invoice_count.first
  end

  def test_invoice_status
    assert_equal 29.55, @sales_analyst.invoice_status(:pending)
    assert_equal 56.95, @sales_analyst.invoice_status(:shipped)
    assert_equal 13.5, @sales_analyst.invoice_status(:returned)
  end

  def test_paid_in_full_returns_true_if_the_invoice_is_paid_in_full
    expected = @sales_analyst.invoice_paid_in_full?(1)

    assert_equal true, expected

    expected = @sales_analyst.invoice_paid_in_full?(200)

    assert_equal true, expected

    expected = @sales_analyst.invoice_paid_in_full?(203)
    assert_equal false, expected


    expected = @sales_analyst.invoice_paid_in_full?(204)
    assert_equal false, expected
  end

  def test_total_returns_total_dollar_amount
    actual = @sales_analyst.invoice_total(1)

    assert_equal 21067.77, actual
    assert_equal BigDecimal, actual.class
  end
end
