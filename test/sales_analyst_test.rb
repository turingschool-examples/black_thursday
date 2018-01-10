require "./test/test_helper"
require "./lib/sales_analyst"
require "./lib/sales_engine"
require "./lib/item"
require "./lib/merchant"

class SalesAnalystTest < MiniTest::Test
  include Calculator
  def setup
    sales_engine = SalesEngine.from_csv({
      :items      => "./test/fixtures/items_fixtures.csv",
      :merchants  => "./test/fixtures/merchants_fixtures.csv",
      :invoices    => "./test/fixtures/invoices_fixtures.csv",
      :invoice_items => "./test/fixtures/invoice_items_fixtures.csv",
      :transactions => "./test/fixtures/transactions_fixtures.csv",
      :customers => "./test/fixtures/customers_fixtures.csv"})

    @sales_analyst = SalesAnalyst.new(sales_engine)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def item_array_maker_returns_array_of_items
    assert_instance_of Array, @sales_analyst.item_array_maker

    assert_instance_of Item, @sales_analyst.item_array_maker[0]
  end

  def test_item_counter_returns_amount_of_items
    assert_equal 1, @sales_analyst.item_counter(12335519)
    assert_equal 2, @sales_analyst.item_counter(12335544)
  end

  def test_average_items_per_merchant_returns_average_item_per_merchant
    assert_equal 1.45, @sales_analyst.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation_returns_standard_dev
    assert_equal 0.82, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_mean_plus_standard_deviation_returns_baseline
    assert_equal 2.27, @sales_analyst.mean_plus_standard_deviation
  end

  def test_merchants_with_high_item_count_returns_array_of_merchants
    assert_instance_of Merchant, @sales_analyst.merchants_with_high_item_count[0]
    assert_equal 2, @sales_analyst.merchants_with_high_item_count.count
  end

  def test_average_item_price_for_merchant_returns_average_item_price
    assert_instance_of BigDecimal, @sales_analyst.average_item_price_for_merchant(12335519)

    assert_equal 3.7, @sales_analyst.average_item_price_for_merchant(12335519)
  end


  def test_merchant_items_sum_returns_sum_of_values
    assert_equal 3.7, @sales_analyst.merchant_items_sum(12335519)

    assert_equal 63, @sales_analyst.merchant_items_sum(12335544)
  end

  def test_average_price_per_merchant_returns_array_of_averages
    assert_equal [0.37e1, 0.35e2, 0.933e1, 0.1e1, 0.125e3, 0.3995e2, 0.315e2, 0.55e2, 0.12e2, 0.15e2, 0.75e0], @sales_analyst.average_price_per_merchant_array_maker
  end

  def test_average_price_per_merchant_returns_sum_of_averages
    assert_equal 328.23, @sales_analyst.average_price_per_merchant_sum
  end

  def test_average_average_price_per_merchant_returns_big_decimal_of_average_average
    assert_instance_of BigDecimal, @sales_analyst.average_average_price_per_merchant
    assert_equal 0.2983e2 , @sales_analyst.average_average_price_per_merchant
  end

  def test_price_price_standard_deviation_returns_standard_dev_for_all_item_prices
    assert_equal 0.3425e2, @sales_analyst.price_standard_deviation
  end

  def test_golden_items_returns_array_of_expensive_items
    assert_instance_of Array, @sales_analyst.golden_items
    assert_instance_of Item, @sales_analyst.golden_items[0]
    assert_equal 1, @sales_analyst.golden_items.count
  end

  def test_count_invoices_returns_float_of_invoices
    assert_equal 119.0, @sales_analyst.count_invoices
  end

  def test_count_merchants_returns_float_of_invoices
    assert_equal 11.0, @sales_analyst.count_merchants
  end

  def test_invoice_array_maker_returns_array_of_amount_of_invoices
    assert_equal [11, 6, 12, 11, 16, 13, 10, 11, 9, 7, 13], @sales_analyst.invoice_array_maker
  end

  def test_average_invoices_per_merchant_returns_rounded_average
    assert_equal 10.82, @sales_analyst.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation_returns_sd
    assert_equal 2.82, @sales_analyst.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count_returns_array_of_merchants
    assert_equal [], @sales_analyst.top_merchants_by_invoice_count
  end

  def test_bottom_merchants_by_invoice_count_returns_array_of_merchants
    assert_equal [], @sales_analyst.bottom_merchants_by_invoice_count
  end

  def test_created_at_day_counter
    assert_equal({1=>24, 2=>15, 4=>15, 0=>21, 6=>21, 3=>15, 5=>8}, @sales_analyst.created_at_day_counter)
  end

  def test_created_at_day_mean
    assert_equal 17, @sales_analyst.created_at_day_mean
  end

  def test_created_at_standard_dev
    assert_equal 5.39, @sales_analyst.created_at_standard_deviation
  end

  def test_top_days_by_invoice_count
    assert_equal ["Monday"], @sales_analyst.top_days_by_invoice_count
  end

  def test_invoice_status_returns_number_of_invoices_with_status
    assert_equal 18.49, @sales_analyst.invoice_status(:returned)
  end

  def test_total_reneue_by_date_returns_zero_when_arbitrary_date
    assert_equal 0, @sales_analyst.total_revenue_by_date("")
  end

  def test_total_revenue_by_date_returns_revenue
    assert_equal 0.1857621e5, @sales_analyst.total_revenue_by_date(Time.parse("2004-09-06"))
  end

  def test_merchants_ranked_by_revenue
    assert_instance_of Merchant, @sales_analyst.merchants_ranked_by_revenue[0]
  end

  def test_merchnats_ranked_by_revenue_can_access_ids
    assert_equal 12335524, @sales_analyst.merchants_ranked_by_revenue[0].id
  end

  def test_top_revenue_earners_ranks_merchants_by_argument_size
    assert_equal 1, @sales_analyst.top_revenue_earners(1).count
    assert_equal 2, @sales_analyst.top_revenue_earners(2).count
  end

  def test_top_revenue_earners_defaults_argument_to_twenty
    assert_equal 11, @sales_analyst.top_revenue_earners.count
  end

  def test_top_revenue_earners_returns_top_merchant
    assert_equal 12335524, @sales_analyst.top_revenue_earners[0].id
    assert_equal "IsisMoonArtesanias", @sales_analyst.top_revenue_earners[0].name
  end

  def test_merchants_with_pending_invoices_returns_merchants
    assert_instance_of Merchant, @sales_analyst.merchants_with_pending_invoices[0]
    assert_equal "TIGHTpinch", @sales_analyst.merchants_with_pending_invoices[0].name
    assert_equal 11, @sales_analyst.merchants_with_pending_invoices.count
  end

  def test_merchants_with_only_one_item_returns_merchants_selling_single_items
    assert_instance_of Merchant, @sales_analyst.merchants_with_only_one_item[0]
    assert_equal "TIGHTpinch", @sales_analyst.merchants_with_only_one_item[0].name
    assert_equal 8, @sales_analyst.merchants_with_only_one_item.count
  end

  def test_merchants_by_month_returns_merchants_by_item_created
    assert_equal "IsisMoonArtesanias" , @sales_analyst.merchants_by_month("July")[0].name
  end


  def test_merchants_returns_nil_when_passed_arbitrary_month
    assert_nil @sales_analyst.merchants_by_month("January")[0]
  end

  def test_revenue_by_merchant_returns_revenue_in_scientific_notation
    assert_instance_of BigDecimal, @sales_analyst.revenue_by_merchant(12335524)
    assert_equal 0.1925252e3, @sales_analyst.revenue_by_merchant(12335524)
  end


  def test_most_sold_item_for_merchant_id_returns_maximum_purchased_items_by_merchant
    assert_equal 263504308, @sales_analyst.most_sold_item_for_merchant(12335521)[0].id
  end

  def test_best_item_form_merchant_returns_the_item
    assert_equal "Sale Adidas originals For Small Kids", @sales_analyst.best_item_for_merchant(12335521).name
  end
end
