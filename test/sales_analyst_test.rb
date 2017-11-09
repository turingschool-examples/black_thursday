require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < MiniTest::Test
  attr_reader :se,
              :sa

  def setup
    @se ||= SalesEngine.from_csv({:items         => "./data/items.csv",
                                  :merchants     => "./data/merchants.csv",
                                  :invoices      => "./data/invoices.csv",
                                  :invoice_items => "./data/invoice_items.csv",
                                  :transactions  => "./data/transactions.csv",
                                  :customers     => "./data/customers.csv"
                                })

    @sa ||= SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sa
    assert_instance_of SalesEngine, sa.se
    assert_instance_of MerchantRepository, sa.se.merchants
    assert_instance_of ItemRepository, sa.se.items
  end

  def test_can_calculate_average_items_per_merchant
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_can_calculate_standard_deviation
    assert_equal 2.39, sa.standard_deviation([2,3,5,6,8])
  end

  def test_sa_can_calculate_standard_deviation_for_fixture
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_sa_can_calculate_standard_deviation_for_full_data_set
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end

  def test_sa_can_find_merchants_that_sell_most_items
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices  => "./data/invoices.csv"
    })

    sa = SalesAnalyst.new(se)

    assert_instance_of Array, sa.merchants_with_high_item_count
    assert_nil sa.merchants_with_high_item_count.first
    assert_equal 0, sa.merchants_with_high_item_count.count
  end

  def test_sa_can_find_average_item_price_for_individual_merchant
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices  => "./data/invoices.csv"
    })
    sa = SalesAnalyst.new(se)

    result = sa.average_item_price_for_merchant(12334112)

    assert_equal 0.55e-1, result
  end

  def test_sa_can_find_average_item_price_for_all_merchants
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices  => "./data/invoices.csv"
    })
    sa = SalesAnalyst.new(se)

    result = sa.average_average_price_per_merchant

    assert_equal 0.12e0, result
  end

  def test_sa_can_find_average_invoices_per_merchant
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices  => "./test/fixtures/invoices_fixture.csv"
    })
    sa = SalesAnalyst.new(se)

    assert_equal 1.33, sa.average_invoices_per_merchant.round(2)
  end

  def test_sa_can_find_stand_deviation_of_average_invoices_per_merchant
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices  => "./test/fixtures/invoices_fixture.csv"
    })
    sa = SalesAnalyst.new(se)

    assert_equal 0.58, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_sa_can_find_merchant_with_most_invoices
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices  => "./test/fixtures/invoices_fixture.csv"
    })
    sa = SalesAnalyst.new(se)

    assert_equal [], sa.top_merchants_by_invoice_count
  end

  def test_sa_can_find_merchant_with_fewest_invoices
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices  => "./test/fixtures/invoices_fixture.csv"
    })
    sa = SalesAnalyst.new(se)

    assert_equal [], sa.bottom_merchants_by_invoice_count
  end

  def test_can_get_hash_with_invoices_matched_to_day_created
    skip
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices  => "./test/fixtures/invoices_fixture.csv"
    })
    sa = SalesAnalyst.new(se)

    assert_instance_of Hash, sa.days_invoice_created
    assert_equal [], sa.days_with_number_of_invoices
  end

  def test_can_find_average_invoices_created_per_day
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices  => "./test/fixtures/invoices_fixture.csv"
    })
    sa = SalesAnalyst.new(se)

    assert_equal 1, sa.average_invoices_per_day
  end

  def test_can_find_standard_deviation_invoices_created_per_day
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices  => "./test/fixtures/invoices_fixture.csv"
    })
    sa = SalesAnalyst.new(se)

    assert_equal 0.0, sa.standard_deviation_invoices_a_day
  end

  def test_top_days_by_invoice_count
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices  => "./test/fixtures/invoices_fixture.csv"
    })
    sa = SalesAnalyst.new(se)

    assert_equal [], sa.top_days_by_invoice_count
  end

  def test_can_get_total_number_of_invoices
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices  => "./test/fixtures/invoices_fixture.csv"
    })
    sa = SalesAnalyst.new(se)

    assert_equal 4, sa.total_number_of_invoices
  end

  def test_can_find_number_of_invoices_pending_shipped_returned
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices  => "./test/fixtures/invoices_fixture.csv"
    })
    sa = SalesAnalyst.new(se)

    assert_equal 2, sa.number_of_invoices_with_status(:pending)
    assert_equal 1, sa.number_of_invoices_with_status(:shipped)
    assert_equal 1, sa.number_of_invoices_with_status(:returned)
  end

  def test_invoice_status_returns_percentage_of_invoices
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
      :invoices  => "./test/fixtures/invoices_fixture.csv"
    })
    sa = SalesAnalyst.new(se)

    assert_equal 50.0, sa.invoice_status(:pending)
    assert_equal 25.0, sa.invoice_status(:shipped)
    assert_equal 25.0, sa.invoice_status(:returned)

  end

  def test_SA_can_find_some_number_of_top_buyers
    assert_equal 20, sa.top_buyers.count
    assert_equal 5, sa.top_buyers.count(5)
  end

  def test_SA_top_merchant_for_customer
    assert_instance_of Merchant, sa.top_merchant_for_customer(100)
  end

  def test_SA_can_find_one_time_buyers
    assert_instance_of Array, sa.one_time_buyers
    assert_instance_of Customer, sa.one_time_buyers.first
    assert_equal 150, sa.one_time_buyers.count
  end

  def test_one_time_buyers_top_items
    assert_instance_of Array, sa.one_time_buyers_top_items
    assert_instance_of Item, sa.one_time_buyers_top_item.first
    assert_equal 1, sa.one_time_buyers_item.count
  end

  def test_SA_finds_highest_volume_item_for_a_customer
    assert_instance_of Array, sa.highest_volume_items(200)
    assert_instance_of Item, sa.highest_volume_items(200).first
    assert_equal 6, sa.highest_volume_items(200).count
  end

  def test_SA_finds_customers_with_unpaid_invoices
    assert_instance_of Array, sa.customers_with_unpaid_invoices
    assert_instance_of Customer, sa.customers_with_unpaid_invoices.first
    assert_equal 786, sa.customers_with_unpaid_invoices.count
  end

  def test_SA_finds_best_invoice_by_revenue
    assert_instance_of Invoice, sa.best_invoice_by_revenue
  end

  def test_SA_can_find_best_invoice_by_quantity
    assert_instance_of Invoice, sa.best_invoice_by_quantity
  end

  def test_SA_can_find_which_items_customer_bought_in_certain_year
    assert_instance_of Array, sa.items_bought_in_year(400, 2002)
    assert_equal 2, sa.items_bought_in_year(400, 2002).count
    assert_instance_of Item, sa.items_bought_in_year(400, 2002).first
  end

end
