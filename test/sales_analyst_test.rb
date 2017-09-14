require_relative 'test_helper'
# require './lib/sales_analyst'
# require './lib/sales_engine'
# require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < MiniTest::Test

  def setup
    se = SalesEngine.from_csv({
          :items     => "./test/fixtures/items_fixture.csv",
          :merchants => "./test/fixtures/merchants_fixture.csv",
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

    assert_equal 2, sa.average_items_per_merchant
  end
end
