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
    sales_engine = stub(:get_all_merchant_items => [['a', 'b', 'c'],
                                                    ['d', 'e'],
                                                    ['f']])
    sa = SalesAnalyst.new(sales_engine)

    assert_equal [3, 2, 1], sa.items_per_merchant
  end

  def test_average_items_per_merchant_returns_proper_value
    sales_engine = stub(:get_all_merchant_items => [['a', 'b', 'c'],
                                                    ['d', 'e'],
                                                    ['f'],
                                                    ['g', 'h', 'i', 'j', 'k']])
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 2.75, sa.average_items_per_merchant
  end

  def test_average_items_per_merchant_standard_deviation
    sales_engine = stub(:get_all_merchant_items => [['a', 'b', 'c'],
                                                    ['d', 'e'],
                                                    ['f'],
                                                    ['g', 'h', 'i', 'j', 'k']])
    sa = SalesAnalyst.new(sales_engine)

    assert_equal 1.707825127659933, sa.average_items_per_merchant_standard_deviation
    assert_equal 1.71, sa.average_items_per_merchant_standard_deviation.round(2)
  end

end
