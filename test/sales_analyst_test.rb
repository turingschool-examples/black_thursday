require './test/test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa

  def setup
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices  => "./test/fixtures/invoices_fixture.csv",
      :transactions  => "./test/fixtures/transactions_fixture.csv",
      :invoice_items => "./test/fixtures/invoice_items_fixture.csv",
      :customers => "./test/fixtures/customers_fixture.csv",
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_has_sales_engine
    assert_instance_of SalesEngine, sa.engine
  end

  def test_method_average_items_per_merchant_returns_float
    mock_se = Minitest::Mock.new
    sa = SalesAnalyst.new(mock_se)
    mock_se.expect(:items_per_merchant,[3,4,5], [])
    assert_equal 4.0, sa.average_items_per_merchant
    mock_se.expect(:items_per_merchant,[22,40,12,19,30], [])
    assert_equal 24.6, sa.average_items_per_merchant
  end

  def test_method_average_items_per_merchant_standard_deviation_returns_float
    mock_se = Minitest::Mock.new
    sa = SalesAnalyst.new(mock_se)
    mock_se.expect(:items_per_merchant,[3,4,5], [])
    assert_equal 1.0, sa.average_items_per_merchant_standard_deviation
    mock_se.expect(:items_per_merchant,[22,40,12,19,30], [])
    assert_equal 10.76, sa.average_items_per_merchant_standard_deviation
  end

  def test_method_merchants_with_high_item_count_returns_array_of_merchants
    assert_instance_of Array, sa.merchants_with_high_item_count
    assert_instance_of Merchant, sa.merchants_with_high_item_count[0]
    assert_equal "barry's berries", sa.merchants_with_high_item_count[0].name
  end

  def test_method_average_average_price_per_merchant_returns_big_decimal
    assert_instance_of BigDecimal, sa.average_average_price_per_merchant
    assert_equal 4.58, sa.average_average_price_per_merchant
  end

  def test_method_golden_items_returns_array_of_items
    assert_instance_of Array, sa.golden_items
    assert_instance_of Item, sa.golden_items[0]
    assert_equal 'description f', sa.golden_items[0].description

  end

  def test_method_average_invoices_per_merchant_returns_float
    assert_instance_of Float, sa.average_invoices_per_merchant
    assert_equal 2.0, sa.average_invoices_per_merchant

  end

  def test_method_average_invoices_per_merchant_standard_deviation_returns_float
    assert_instance_of Float, sa.average_invoices_per_merchant_standard_deviation
    assert_equal 0.82, sa.average_invoices_per_merchant_standard_deviation

  end

  def test_method_top_merchants_by_invoice_count_returns_array_of_merchants
    assert_instance_of Array, sa.top_merchants_by_invoice_count
    assert_equal [], sa.top_merchants_by_invoice_count

  end

  def test_method_bottom_merchants_by_invoice_count_returns_array_of_merchants
    assert_instance_of Array, sa.bottom_merchants_by_invoice_count
    assert_equal [], sa.bottom_merchants_by_invoice_count

  end

  def test_method_top_days_by_invoice_count_returns_array
    mock_se = Minitest::Mock.new
    sa = SalesAnalyst.new(mock_se)
    mock_se.expect(:total_invoices_by_weekday,{"Saturday"=>729,
                                               "Friday"=>701,
                                               "Wednesday"=>741,
                                               "Monday"=>696,
                                               "Sunday"=>708,
                                               "Tuesday"=>692,
                                               "Thursday"=>718}, [])
    assert_equal ["Wednesday"], sa.top_days_by_invoice_count
  end

  def test_method_invoice_status_sum_for_all_three_is_100_percent
    sum = sa.invoice_status(:pending) +
          sa.invoice_status(:shipped) +
          sa.invoice_status(:returned)
    assert_equal 100.0, sum
  end

  def test_method_top_merchant_for_customer_returns_merchant
    assert_instance_of Merchant, sa.top_merchant_for_customer(100)
    assert_equal 1000, sa.top_merchant_for_customer(100).id
  end

  def test_method_top_buyers_returns_customer_array
    assert_instance_of Array, sa.top_buyers
    assert_instance_of Customer, sa.top_buyers[0]
    assert_equal "Joey", sa.top_buyers.first.first_name
    assert_equal 5, sa.top_buyers(5).length
    assert_equal 9, sa.top_buyers.length
  end

  def test_method_top_merchant_for_customer_returns_merchant
    assert_instance_of Merchant, sa.top_merchant_for_customer(100)
    assert_equal "adam's bar", sa.top_merchant_for_customer(100).name
    assert_equal "danny's cavern", sa.top_merchant_for_customer(400).name
    assert_equal "barry's berries", sa.top_merchant_for_customer(700).name
  end

  def test_method_one_time_buyers_returns_customer_array
    assert_instance_of Array, sa.one_time_buyers
    assert_equal 2, sa.one_time_buyers.length
    assert_equal "Ondricka", sa.one_time_buyers[0].last_name
  end

  def test_method_items_bought_in_year_returns_item_array
    assert_instance_of Array, sa.items_bought_in_year(100, 2000)
    assert_instance_of Array, sa.items_bought_in_year(100, 2015)
    assert_equal [], sa.items_bought_in_year(100, 2000)
    assert_equal 3, sa.items_bought_in_year(100, 2009).length
  end

  def test_method_customers_with_unpaid_invoices_returns_customer_array
    assert_instance_of Array, sa.customers_with_unpaid_invoices
    assert_equal 6, sa.customers_with_unpaid_invoices.length
    assert_equal 400, sa.customers_with_unpaid_invoices[0].id
    assert_equal "Braun", sa.customers_with_unpaid_invoices[0].last_name
  end

  def test_method_best_invoice_by_revenue_returns_invoice
    assert_instance_of Invoice, sa.best_invoice_by_revenue
    assert_equal 1, sa.best_invoice_by_revenue.id
  end

  def test_method_best_invoice_by_quantity_returns_invoice
    assert_instance_of Invoice, sa.best_invoice_by_quantity
    assert_equal 1, sa.best_invoice_by_quantity.id
  end

  def test_method_one_time_buyers_item_returns_array_of_item
    assert_instance_of Array, sa.one_time_buyers_item
    assert_equal 1, sa.one_time_buyers_item.length
    assert_equal 'name c', sa.one_time_buyers_item[0].name

  end

end
