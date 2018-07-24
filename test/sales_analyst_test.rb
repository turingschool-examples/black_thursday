require_relative 'test_helper'
require_relative '../lib/sales_analyst.rb'
require_relative '../lib/sales_engine.rb'

class SalesAnalystTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.from_csv({
                        :items     => "./data/items.csv",
                        :merchants => "./data/merchants.csv",
                      })
    @sales_analyst = @sales_engine.analyst
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sales_analyst
  end

  def test_it_can_average_items_per_merchant
    expected = 2.88
    actual = @sales_analyst.average_items_per_merchant

    assert_equal expected, actual
  end

  def test_it_can_find_stddev_of_average_items_per_merchant
    expected = 3.26
    actual = @sales_analyst.average_items_per_merchant_standard_deviation

    assert_equal expected, actual
  end

  def test_which_merchants_exceed_1_stdev_higher_than_average_number_products
    expected = 52
    actual = @sales_analyst.merchants_with_high_item_count.count

    assert_equal expected, actual
  end
end
