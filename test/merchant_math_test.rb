require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/sales_analyst"
# require "./lib/item_repository"
# require "./lib/merchant_repository"
# require "./lib/merchant"
# require "./lib/item"



class TestMerchantModule < Minitest::Test

  def setup
    csv_hash = {
      :items     => "./test/test_fixtures/items_medium.csv",
      :merchants => "./test/test_fixtures/merchants_medium.csv",
    }
    sales_engine = SalesEngine.from_csv(csv_hash)
    @sa = SalesAnalyst.new(sales_engine)
  end

  def test_average_things_per_merchant
  end


  def test_average_things_per_merchant_standard_deviation

  end

  def test_make_merchants_and_things

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
      :items     => "./test/test_fixtures/items_medium.csv",
      :merchants => "./test/test_fixtures/merchants_medium.csv",
    }
    se = SalesEngine.from_csv(csv_hash)
    sa_medium_items = SalesAnalyst.new(se)
    assert_instance_of Array, sa_medium_items.golden_items
    assert_instance_of Item, sa_medium_items.golden_items[0]
    assert_equal "Test listing", sa_medium_items.golden_items[0].name
  end



  def test_it_finds_the_average

  end

  def test_it_squares_the_average_difference

  end

  def test_it_finds_standard_deviation
  end

  def test_it_finds_avg_plus_2x_std_dev

 end


  def test_it_finds_two_standard_deviations_above

  end

  def test_it_finds_two_standard_deviations_below

  end


  def test_it_finds_one_standard_deviations_above

  end

end
