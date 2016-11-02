require './test/test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'


class SalesAnalystTest < Minitest::Test
  attr_reader :se,
              :sa

  def setup
    @se = SalesEngine.from_csv({
  :items     => "./fixture/item_fixture_2.csv",
  :merchants => "./data/merchants_fixture.csv",
  })
  @sa = SalesAnalyst.new(@se)
  end

  def test_it_exists
    assert @sa
  end

  def test_new_sales_analyst_initializes_as_sales_engine
    result= sa.sales_engine.class
    assert_equal SalesEngine, result
  end

  def test_average_items_per_merchant
    result = sa.average_items_per_merchant
    assert_equal 0.17, result
  end

  def test_standard_deviation_gives_standard_dev
    array = [3,4,5]
    result = sa.find_standard_deviation(array)
    assert_equal 1, result
  end
end
