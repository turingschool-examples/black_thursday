require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < MiniTest::Test

  def setup
    se = SalesEngine.from_csv({
          :items     => "./data/items_fixture.csv",
          :merchants => "./data/merchants_fixture.csv",
        })
    se.merchants
    se.items
    SalesAnalyst.new(se)
  end

  def test_it_exists
    sa = setup

    assert_instance_of SalesAnalyst, sa
  end

  def test_it_can_find_average_items_per_merchant
    sa = setup

    assert_equal 1, sa.average_items_per_merchant
  end
end
