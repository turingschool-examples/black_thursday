require_relative '../test/test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({merchants: "./test/fixtures/merchants_fixture.csv",
                                          items: "./test/fixtures/items_fixture.csv",
                                          invoices: "./test/fixtures/invoices_fixture.csv",
                                          invoice_items: "./test/fixtures/invoice_items_fixture.csv",
                                          transactions: "./test/fixtures/transactions_fixture.csv",
                                          customers: "./test/fixtures/customer_fixture.csv" })
  end

  def test_it_exists
    sales_engine = mock('se')
    sa = SalesAnalyst.new(sales_engine)

    assert_instance_of SalesAnalyst, sa
  end

  def test_it_starts_with_a_sales_engine
    sales_engine = mock('se')
    sa = SalesAnalyst.new(sales_engine)

    assert_equal sales_engine, sa.sales_engine
  end

  def test_items_per_merchant_returns_array_of_items_per_merchant
    sales_engine = stub(:merchants_with_items => { m1: ['a', 'b', 'c'],
                                                   m2: ['d', 'e'],
                                                   m3: ['f'],
                                                   m4: ['g', 'h', 'i', 'j', 'k']})
    sa = SalesAnalyst.new(sales_engine)

    assert_equal [3, 2, 1, 5], sa.items_per_merchant
  end

  def test_average_items_per_merchant_returns_proper_value
    sales_engine = stub(:merchants_with_items => { m1: ['a', 'b', 'c'],
                                                   m2: ['d', 'e'],
                                                   m3: ['f'],
                                                   m4: ['g', 'h', 'i', 'j', 'k']})
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 2.75, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    sales_engine = stub(:merchants_with_items => { m1: ['a', 'b', 'c'],
                                                   m2: ['d', 'e'],
                                                   m3: ['f'],
                                                   m4: ['g', 'h', 'i', 'j', 'k']})
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 1.71, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count_returns_merchant_above_stdev
    sales_engine = stub(:merchants_with_items => { m1: ['a', 'b', 'c'],
                                                   m2: ['d', 'e'],
                                                   m3: ['f'],
                                                   m4: ['g', 'h', 'i', 'j', 'k'],
                                                   m5: ['z', 'x', 'y', 'w', 'u']})
    sa = SalesAnalyst.new(sales_engine)

    assert_equal [:m4, :m5], sa.merchants_with_high_item_count
  end

  def test_average_item_price_for_merchant_works
    sales_engine = stub(:get_prices_from_one_merchant => [100.00, 200.00, 300.00, 400.00])

    sa = SalesAnalyst.new(sales_engine)

    assert_equal 250.00, sa.average_item_price_for_merchant(123)
  end

  def test_average_average_item_price_for_merchant_works
    sales_engine = stub(:merchants_with_prices => { m1: [100.00, 100.00, 300.00],
                                                    m2: [100.00, 100.00],
                                                    m3: [100.00],
                                                    m4: [100.00, 100.00, 300.00, 300.00, 300.00],
                                                    m5: [100.00, 300.00, 300.00, 300.00, 300.00]})

    sa = SalesAnalyst.new(sales_engine)

    assert_equal 169.33, sa.average_average_price_per_merchant
  end

  def test_all_item_prices_returns_array_of_prices_from_hash
    sales_engine = stub(:merchants_with_prices => { m1: [100.00, 100.00, 300.00],
                                                    m2: [100.00, 100.00],
                                                    m3: [100.00],
                                                    m4: [100.00, 100.00, 300.00, 300.00, 300.00],
                                                    m5: [100.00, 300.00, 300.00, 300.00, 300.00]})

    sa = SalesAnalyst.new(sales_engine)

    assert_equal [100.0, 100.0, 300.0, 100.0, 100.0, 100.0,
                  100.0, 100.0, 300.0, 300.0, 300.0, 100.0,
                  300.0, 300.0, 300.0, 300.0], sa.all_item_prices
  end

  def test_average_item_price_works
    sales_engine = stub(:merchants_with_prices => { m1: [100.00, 100.00, 300.00],
                                                    m2: [100.00, 100.00],
                                                    m3: [100.00],
                                                    m4: [100.00, 100.00, 300.00, 300.00, 300.00],
                                                    m5: [100.00, 300.00, 300.00, 300.00, 300.00]})

    sa = SalesAnalyst.new(sales_engine)

    assert_equal 200.00, sa.average_item_price.round(2)
  end

  def test_item_prices_standard_deviation_returns_standard_deviation
    sales_engine = stub(:merchants_with_prices => { m1: [100.00, 100.00, 300.00],
                                                    m2: [100.00, 100.00],
                                                    m3: [100.00],
                                                    m4: [100.00, 100.00, 300.00, 300.00, 300.00],
                                                    m5: [100.00, 300.00, 300.00, 300.00, 300.00]})

    sa = SalesAnalyst.new(sales_engine)

    assert_equal 103.28, sa.item_prices_standard_deviation.round(2)
  end

  def test_find_golden_prices_returns_golden_prices
    sales_engine = stub(:merchants_with_prices => { m1: [100.00, 100.00, 100.00],
                                                    m2: [100.00, 100.00],
                                                    m3: [100.00],
                                                    m4: [100.00, 100.00, 100.00, 100.00, 100.00],
                                                    m5: [100.00, 100.00, 100.00, 600.00, 700.00]})

    sa = SalesAnalyst.new(sales_engine)

    assert_equal [600.00, 700.00], sa.golden_prices
  end

  def test_golden_items_returns_golden_priced_items
    # golden_prices argument not being passed
    item = mock('shoe')
    sales_engine = stub(:merchants_with_prices => { m1: [100.00, 100.00, 100.00],
                                                    m2: [100.00, 100.00],
                                                    m3: [100.00],
                                                    m4: [100.00, 100.00, 100.00, 100.00, 100.00],
                                                    m5: [100.00, 100.00, 100.00, 600.00, 700.00]},
                        :get_items_by_price    => item)

    sa = SalesAnalyst.new(sales_engine)

    assert_equal [item, item], sa.golden_items
  end

  def test_golden_items_returns_proper_amount_of_items
    sa = SalesAnalyst.new(@sales_engine)

    assert_equal 2, sa.golden_items.count
  end

  def test_invoice_count_per_merchant_returns_hash_of_invoice_count_per_merchant
    sales_engine = stub(:merchants_with_invoices => { m1: ['a', 'b', 'c'],
                                                      m2: ['d', 'e'],
                                                      m3: ['f'],
                                                      m4: ['g', 'h', 'i', 'j', 'k']})
    sa = SalesAnalyst.new(sales_engine)

    assert_equal({m1: 3, m2: 2, m3: 1, m4: 5}, sa.invoice_count_per_merchant)
  end

  def test_average_invoices_per_merchant_works
    sales_engine = stub(:merchants_with_invoices => { m1: ['a', 'b', 'c'],
                                                      m2: ['d', 'e'],
                                                      m3: ['f'],
                                                      m4: ['g', 'h', 'i', 'j', 'k']})
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 2.75, sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    sales_engine = stub(:merchants_with_invoices => { m1: ['a', 'b', 'c'],
                                                      m2: ['d', 'e'],
                                                      m3: ['f'],
                                                      m4: ['g', 'h', 'i', 'j', 'k']})
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 1.71, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count_returns_top_performing_merchants
    sales_engine = stub(:merchants_with_invoices => { m1: ['a', 'b', 'c', 'z'],
                                                      m2: ['d', 'e', 'r', 'z'],
                                                      m3: ['f', 'p', 'q', 'z'],
                                                      m4: ['g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o'],
                                                      m5: ['a', 'b', 'c', 'z'],
                                                      m6: ['a', 'b', 'c', 'z'],
                                                      m7: ['a', 'b', 'c', 'z'],
                                                      m8: ['a', 'b', 'c', 'z']})
    sa = SalesAnalyst.new(sales_engine)

    assert_equal [:m4], sa.top_merchants_by_invoice_count
  end

  def test_bottom_merchants_by_invoice_count_returns_bottom_performing_merchants
    sales_engine = stub(:merchants_with_invoices => { m1: ['a', 'b', 'c', 'z'],
                                                      m2: ['d', 'e', 'r', 'z'],
                                                      m3: ['f', 'p', 'q', 'z'],
                                                      m4: ['g'],
                                                      m5: ['a', 'b', 'c', 'z'],
                                                      m6: ['a', 'b', 'c', 'z'],
                                                      m7: ['a', 'b', 'c', 'z'],
                                                      m8: ['a', 'b', 'c', 'z']})
    sa = SalesAnalyst.new(sales_engine)

    assert_equal [:m4], sa.bottom_merchants_by_invoice_count
  end

  def test_invoices_per_weekday_returns_hash_of_days_with_associated_invoices
    sa = SalesAnalyst.new(@sales_engine)

    assert_equal 1, sa.invoices_per_weekday["Sunday"].count
    assert_equal 4, sa.invoices_per_weekday["Monday"].count
    assert_equal 2, sa.invoices_per_weekday["Tuesday"].count
    assert_equal 1, sa.invoices_per_weekday["Wednesday"].count
    assert_equal 1, sa.invoices_per_weekday["Thursday"].count
    assert_equal 6, sa.invoices_per_weekday["Friday"].count
    assert_equal 5, sa.invoices_per_weekday["Saturday"].count
  end

  def test_invoice_counts_per_weekday_returns_hash_of_days_with_associated_invoice_counts
    sa = SalesAnalyst.new(@sales_engine)

    counts_per_weekday = {"Sunday" => 1, "Monday" => 4, "Tuesday" => 2, "Wednesday" => 1, "Thursday" => 1, "Friday" => 6, "Saturday" => 5}

    assert_equal counts_per_weekday, sa.invoice_counts_per_weekday
  end

  def test_average_invoice_counts_per_day_works
    sa = SalesAnalyst.new(@sales_engine)

    assert_equal 2.86, sa.average_invoice_counts_per_day.round(2)
  end

  def test_average_invoices_per_day_standard_deviation_works
  sa = SalesAnalyst.new(@sales_engine)

    assert_equal 2.12, sa.average_invoices_per_day_standard_deviation
  end

  def test_sort_by_weekday_works
    sales_engine = "POOP"
    sa = SalesAnalyst.new(sales_engine)

    mixed_up_weekdays = ["Friday", "Sunday", "Monday"]

    assert_equal ["Sunday", "Monday", "Friday"], sa.sort_by_weekday(mixed_up_weekdays)
  end

  def test_top_days_by_invoice_count
    sa = SalesAnalyst.new(@sales_engine)

    assert_equal ["Friday", "Saturday"], sa.top_days_by_invoice_count
  end

  def test_invoice_status_returns_percent_of_status
    sa = SalesAnalyst.new(@sales_engine)

    assert_equal 45.0, sa.invoice_status("pending")
    assert_equal 45.0, sa.invoice_status(:pending)
    assert_equal 55.0, sa.invoice_status("shipped")
    assert_equal 55.0, sa.invoice_status(:shipped)
    assert_equal 0.0, sa.invoice_status("returned")
    assert_equal 0.0, sa.invoice_status(:returned)
  end

  def test_total_revenue_by_date_works
    sa = SalesAnalyst.new(@sales_engine)

    assert_equal 2047.06, sa.total_revenue_by_date("2012-11-23")
    assert_equal 2047.06, sa.total_revenue_by_date(Time.parse("2012-11-23"))
  end

  def test_top_earners_ids
    sa = SalesAnalyst.new(@sales_engine)

    assert_equal [12334141, 12334185, 12334113, 12334105], sa.top_earners_ids(4)
  end

  def test_top_revenue_earners
    sa = SalesAnalyst.new(@sales_engine)

    assert_equal 12334141, sa.top_revenue_earners(4)[0].id
    assert_equal 12334185, sa.top_revenue_earners(4)[1].id
    assert_equal 12334113, sa.top_revenue_earners(4)[2].id
    assert_equal 12334105, sa.top_revenue_earners(4)[3].id
  end

  def test_merchants_with_pending_invoices
    sa = SalesAnalyst.new(@sales_engine)

    assert_equal 12334185, sa.merchants_with_pending_invoices[0].id
    assert_equal "Disney", sa.merchants_with_pending_invoices[0].name
  end

  def test_merchants_ranked_by_revenue
    sa = SalesAnalyst.new(@sales_engine)

    assert_equal "SeriousCompany", sa.merchants_ranked_by_revenue.first.name
    assert_equal "Shopin1901", sa.merchants_ranked_by_revenue.last.name
  end

  def test_merchants_with_only_one_item
    sales_engine = stub(:merchants_with_items => { m1: ['a'],
                                                   m2: ['d', 'e', 'r', 'z'],
                                                   m3: ['f', 'p', 'q', 'z'],
                                                   m4: ['g'],
                                                   m5: ['a', 'b', 'c', 'z'],
                                                   m6: ['a', 'b', 'c', 'z'],
                                                   m7: ['a', 'b', 'c', 'z'],
                                                   m8: ['z']})
    sa = SalesAnalyst.new(sales_engine)

    one_item_merchants = sa.merchants_with_only_one_item

    assert_equal 3, one_item_merchants.count
    assert_equal :m1, one_item_merchants.first
    assert_equal :m8, one_item_merchants.last
  end

  def test_one_item_merchants_by_month
    m1 = stub(:created_at => "2009-03-21")
    m4 = stub(:created_at => "2011-05-08")
    m8 = stub(:created_at => "20014-03-12")
    sales_engine = stub(:merchants_with_items => { m1  => ['a'],
                                                   :m2 => ['d', 'e', 'r', 'z'],
                                                   :m3 => ['f', 'p', 'q', 'z'],
                                                   m4  => ['g'],
                                                   :m5 => ['a', 'b', 'c', 'z'],
                                                   :m6 => ['a', 'b', 'c', 'z'],
                                                   :m7 => ['a', 'b', 'c', 'z'],
                                                   m8  => ['z']})
    sa = SalesAnalyst.new(sales_engine)

    merchants_by_month = sa.one_item_merchants_by_month

    assert_equal 2, merchants_by_month.count
    assert_equal m4, merchants_by_month[5].first
    assert_equal m1, merchants_by_month[3].first
    assert_equal m8, merchants_by_month[3].last
  end

  def test_merchants_with_only_one_item_registered_in_month
    m1 = stub(:created_at => "2009-03-21")
    m4 = stub(:created_at => "2011-05-08")
    m8 = stub(:created_at => "20014-03-12")
    sales_engine = stub(:merchants_with_items => { m1  => ['a'],
                                                   :m2 => ['d', 'e', 'r', 'z'],
                                                   :m3 => ['f', 'p', 'q', 'z'],
                                                   m4  => ['g'],
                                                   :m5 => ['a', 'b', 'c', 'z'],
                                                   :m6 => ['a', 'b', 'c', 'z'],
                                                   :m7 => ['a', 'b', 'c', 'z'],
                                                   m8  => ['z']})
    sa = SalesAnalyst.new(sales_engine)

    one_item_merchants_registered_by_month = sa.merchants_with_only_one_item_registered_in_month("March")

    assert_equal 2, one_item_merchants_registered_by_month.count
    assert_equal m1, one_item_merchants_registered_by_month.first
    assert_equal m8, one_item_merchants_registered_by_month.last
  end

  def test_revenue_by_merchant
    sa = SalesAnalyst.new(@sales_engine)

    assert_equal 13795.59, sa.revenue_by_merchant(12334141)
    assert_equal 3607.91, sa.revenue_by_merchant(12334105)
    assert_equal 12254.42, sa.revenue_by_merchant(12334185)
    assert_equal 8860.77, sa.revenue_by_merchant(12334113)
  end

  def test_most_sold_item_for_merchant
    sales_engine = stub(:link_merchant_ids_with_most_sold_items => { 1 => ['a'],
                                                                     2 => ['d', 'e', 'r', 'z'],
                                                                     3 => ['f', 'p', 'q', 'z'],
                                                                     4 => ['g'],
                                                                     5 => ['a', 'b', 'c', 'z'],
                                                                     6 => ['a', 'b', 'c', 'z'],
                                                                     7 => ['a', 'b', 'c', 'z'],
                                                                     8 => ['z']})
    sa = SalesAnalyst.new(sales_engine)

    assert_equal ['d', 'e', 'r', 'z'], sa.most_sold_item_for_merchant(2)
  end

  def test_best_item_for_merchant
    sales_engine = stub(:link_merchant_ids_with_best_items => { 1 => 50,
                                                                2 => 100,
                                                                3 => 25,
                                                                4 => 75,
                                                                5 => 80,
                                                                6 => 95,
                                                                7 => 85,
                                                                8 => 30 })
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 95, sa.best_item_for_merchant(6)
  end

end
