require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/sales_analyst"
# require "./lib/item_repository"
# require "./lib/merchant_repository"
# require "./lib/merchant"
# require "./lib/item"



class TestSalesAnalyst < Minitest::Test

  attr_reader :sa

  def setup
    csv_hash = {
      :items     => "./test/test_data/items_short.csv",
      :merchants => "./test/test_data/merchants_short.csv",
    }
    sales_engine = SalesEngine.from_csv(csv_hash)
    @sa = SalesAnalyst.new(sales_engine)
  end

  def test_its_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_averages_items_per_merchant
    assert_equal 1.33, sa.average_items_per_merchant
  end

  def test_it_takes_a_standard_deviation
    assert_equal 0.58, sa.average_items_per_merchant_standard_deviation
  end

  def test_it_finds_merchants_with_high_item_count
    assert_instance_of Array, sa.merchants_with_high_item_count
    assert_instance_of Merchant, sa.merchants_with_high_item_count[0]
  end

  def test_it_finds_average_item_price_for_merchant
    assert_equal BigDecimal.new(13.25, 4), sa.average_item_price_for_merchant(12334185)
  end

  def test_it_sums_averages_across_merchants_and_averages
    assert_equal BigDecimal.new(3.31, 4), sa.average_average_price_per_merchant
  end

  def test_it_finds_average_item_price_for_merchant
    assert_equal 1712.25, sa. average_item_price
  end

  def test_it_squares_each_average_difference
    assert_equal 2219300.75, sa.square_each_item_average_difference
  end

  def test_divide_squared_differences_by_total_then_sqrt
    assert_equal 860.097, sa.standard_deviation_for_item_cost
  end

  def test_it_returns_golden_items
    csv_hash = {
      :items     => "./test/test_data/items_medium.csv",
      :merchants => "./test/test_data/merchants_short.csv",
    }
    se = SalesEngine.from_csv(csv_hash)
    sa_medium_items = SalesAnalyst.new(se)
    assert_instance_of Array, sa_medium_items.golden_items
    assert_instance_of Item, sa_medium_items.golden_items[0]
    assert_equal "Test listing", sa_medium_items.golden_items[0].name
  end

end
