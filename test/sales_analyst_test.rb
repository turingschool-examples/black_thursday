require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa, :se
  def setup
    files = ({:items => "./test/fixture/item_fixture.csv",
              :merchants => "./test/fixture/merchant_fixture.csv",
              :invoices =>"./data/invoices.csv"})
    @se = SalesEngine.from_csv(files)
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, setup
  end

  def test_it_averages_items_per_merchant
    assert_equal 0.83, setup.average_items_per_merchant
  end

  def test_item_count_per_merchants
    result = setup.counts_per_merchant(se.method(:find_merchant_items))

    assert_equal 6, result.count
  end

  def test_item_count_per_merchants_from_fixture
    result = setup.counts_per_merchant(se.method(:find_merchant_items))

    assert_instance_of Array, result
    assert_equal 6, result.count
  end

  def test_item_count_subtracts_from_average_items
    assert_equal 0.69, setup.variance_of_items[1]
  end

  def test_it_sums_array
    assert_equal 3.48, setup.sum_array
  end

  def test_it_std_deviates
    assert_equal 0.83, setup.average_items_per_merchant_standard_deviation
  end

  def test_merchant_list_with_high_item_count
    files = ({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    se = SalesEngine.from_csv(files)
    s_a = SalesAnalyst.new(se)
    assert_equal 52, s_a.merchants_with_high_item_count.count
  end

  def test_it_averages_item_price_for_merchant
    assert_instance_of BigDecimal, setup.average_item_price_for_merchant(12334185)
    assert_equal 0.1117e2, setup.average_item_price_for_merchant(12334185)
  end

  def test_average_average_price_per_merchant
    files = ({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    se = SalesEngine.from_csv(files)
    s_a = SalesAnalyst.new(se)

    assert_instance_of BigDecimal, s_a.average_average_price_per_merchant
    assert_equal 0.35029e3, s_a.average_average_price_per_merchant
  end

  def test_find_average_item_price
    files = ({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    se = SalesEngine.from_csv(files)
    s_a = SalesAnalyst.new(se)

    assert_equal 0.25106e3, s_a.average_item_price
  end

  def test_golden_items
    files = ({:items => "./data/items.csv", :merchants => "./data/merchants.csv"})
    se = SalesEngine.from_csv(files)
    s_a = SalesAnalyst.new(se)

    assert_equal 5, s_a.golden_items.count
  end

end
