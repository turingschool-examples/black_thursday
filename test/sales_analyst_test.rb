require_relative '../test/test_helper'
require_relative '../lib/sales_analyst'

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

    assert_equal 103.28, sa.item_prices_standard_deviation
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

end
