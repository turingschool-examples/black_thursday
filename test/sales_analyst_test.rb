require './test/test_helper'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({
      :items     => "./data/items_test_data.csv",
      :merchants => "./data/merchants_test_data.csv",})
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_can_return_sum_of_all_item_prices
    assert_equal 116268.99, @sa.all_prices
  end

end
