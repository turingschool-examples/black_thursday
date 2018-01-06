require_relative '../test/test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

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
    sales_engine = stub(:get_all_merchant_items => { m1: ['a', 'b', 'c'],
                                                     m2: ['d', 'e'],
                                                     m3: ['f'],
                                                     m4: ['g', 'h', 'i', 'j', 'k']})
    sa = SalesAnalyst.new(sales_engine)

    assert_equal [3, 2, 1, 5], sa.items_per_merchant
  end

  def test_average_items_per_merchant_returns_proper_value
    sales_engine = stub(:get_all_merchant_items => { m1: ['a', 'b', 'c'],
                                                     m2: ['d', 'e'],
                                                     m3: ['f'],
                                                     m4: ['g', 'h', 'i', 'j', 'k']})
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 2.75, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    sales_engine = stub(:get_all_merchant_items => { m1: ['a', 'b', 'c'],
                                                     m2: ['d', 'e'],
                                                     m3: ['f'],
                                                     m4: ['g', 'h', 'i', 'j', 'k']})
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 1.71, sa.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count_returns_merchant_above_stdev
    sales_engine = stub(:get_all_merchant_items => { m1: ['a', 'b', 'c'],
                                                     m2: ['d', 'e'],
                                                     m3: ['f'],
                                                     m4: ['g', 'h', 'i', 'j', 'k'],
                                                     m5: ['z', 'x', 'y', 'w', 'u']})
    sa = SalesAnalyst.new(sales_engine)

    assert_equal [:m4, :m5], sa.merchants_with_high_item_count
  end

  def test_average_item_price_for_merchant_works
    sales_engine = stub(:get_one_merchant_prices => [100.00, 200.00, 300.00, 400.00])

    sa = SalesAnalyst.new(sales_engine)

    assert_equal 250.00, sa.average_item_price_for_merchant(123)
  end

  def test_average_average_item_price_for_merchant_works
    sales_engine = stub(:get_all_merchant_prices => { m1: [100.00, 100.00, 300.00],
                                                      m2: [100.00, 100.00],
                                                      m3: [100.00],
                                                      m4: [100.00, 100.00, 300.00, 300.00, 300.00],
                                                      m5: [100.00, 300.00, 300.00, 300.00, 300.00]})

    sa = SalesAnalyst.new(sales_engine)

    assert_equal 169.33, sa.average_average_price_per_merchant
  end

  def test_all_item_prices_returns_array_of_prices_from_hash
    sales_engine = stub(:get_all_merchant_prices => { m1: [100.00, 100.00, 300.00],
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
    sales_engine = stub(:get_all_merchant_prices => { m1: [100.00, 100.00, 300.00],
                                                      m2: [100.00, 100.00],
                                                      m3: [100.00],
                                                      m4: [100.00, 100.00, 300.00, 300.00, 300.00],
                                                      m5: [100.00, 300.00, 300.00, 300.00, 300.00]})

    sa = SalesAnalyst.new(sales_engine)

    assert_equal 200.00, sa.average_item_price.round(2)
  end

  def test_item_prices_standard_deviation_returns_standard_deviation
    sales_engine = stub(:get_all_merchant_prices => { m1: [100.00, 100.00, 300.00],
                                                      m2: [100.00, 100.00],
                                                      m3: [100.00],
                                                      m4: [100.00, 100.00, 300.00, 300.00, 300.00],
                                                      m5: [100.00, 300.00, 300.00, 300.00, 300.00]})

    sa = SalesAnalyst.new(sales_engine)

    assert_equal 103.28, sa.item_prices_standard_deviation.round(2)
  end

  def test_find_golden_prices_returns_golden_prices
    sales_engine = stub(:get_all_merchant_prices => { m1: [100.00, 100.00, 100.00],
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
    sales_engine = stub(:get_all_merchant_prices => { m1: [100.00, 100.00, 100.00],
                                                      m2: [100.00, 100.00],
                                                      m3: [100.00],
                                                      m4: [100.00, 100.00, 100.00, 100.00, 100.00],
                                                      m5: [100.00, 100.00, 100.00, 600.00, 700.00]},
                        :search_ir_by_price => item)

    sa = SalesAnalyst.new(sales_engine)

    assert_equal [item, item], sa.golden_items
  end

  def test_golden_items_returns_proper_amount_of_items
    #DONT FORGET ITEMS COPY FIXTURE
    se = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_copy.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv" })
    sa = SalesAnalyst.new(se)

    assert_equal 2, sa.golden_items.count
  end

  def test_invoice_count_per_merchant_returns_hash_of_invoice_count_per_merchant
    sales_engine = stub(:get_all_merchant_invoices => { m1: ['a', 'b', 'c'],
                                                        m2: ['d', 'e'],
                                                        m3: ['f'],
                                                        m4: ['g', 'h', 'i', 'j', 'k']})
    sa = SalesAnalyst.new(sales_engine)

    assert_equal({m1: 3, m2: 2, m3: 1, m4: 5}, sa.invoice_count_per_merchant)
  end

  def test_average_invoices_per_merchant_works
    sales_engine = stub(:get_all_merchant_invoices => { m1: ['a', 'b', 'c'],
                                                        m2: ['d', 'e'],
                                                        m3: ['f'],
                                                        m4: ['g', 'h', 'i', 'j', 'k']})
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 2.75, sa.average_invoices_per_merchant
  end

  def test_average_invoices_per_merchant_standard_deviation
    sales_engine = stub(:get_all_merchant_invoices => { m1: ['a', 'b', 'c'],
                                                        m2: ['d', 'e'],
                                                        m3: ['f'],
                                                        m4: ['g', 'h', 'i', 'j', 'k']})
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 1.71, sa.average_invoices_per_merchant_standard_deviation
  end

  def test_top_merchants_by_invoice_count_returns_top_performing_merchants
    # need test fixture below???
    sales_engine = stub(:get_all_merchant_invoices => { m1: ['a', 'b', 'c', 'z'],
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
    sales_engine = stub(:get_all_merchant_invoices => { m1: ['a', 'b', 'c', 'z'],
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
    sales_engine = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_copy.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv" })
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 1, sa.invoices_per_weekday["Sunday"].count
    assert_equal 4, sa.invoices_per_weekday["Monday"].count
    assert_equal 2, sa.invoices_per_weekday["Tuesday"].count
    assert_equal 1, sa.invoices_per_weekday["Wednesday"].count
    assert_equal 1, sa.invoices_per_weekday["Thursday"].count
    assert_equal 5, sa.invoices_per_weekday["Friday"].count
    assert_equal 6, sa.invoices_per_weekday["Saturday"].count
  end

  def test_invoice_counts_per_weekday_returns_hash_of_days_with_associated_invoice_counts
    sales_engine = SalesEngine.from_csv({ merchants: "./test/fixtures/merchants_fixture.csv",
                                items: "./test/fixtures/items_copy.csv",
                                invoices: "./test/fixtures/invoices_fixture.csv" })
    sa = SalesAnalyst.new(sales_engine)

    counts_per_weekday = {"Sunday" => 1, "Monday" => 4, "Tuesday" => 2, "Wednesday" => 1, "Thursday" => 1, "Friday" => 5, "Saturday" => 6}

    assert_equal counts_per_weekday, sa.invoice_counts_per_weekday
  end

end
