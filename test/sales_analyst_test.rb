require './test/test_helper'
require './lib/sales_analyst'
require 'pry'
class SalesAnalystTest < Minitest::Test
  attr_reader :sa
  def setup
    se = SalesEngine.from_csv({ items: "./sa_fixtures/items.csv",
                                merchants: "./sa_fixtures/merchants.csv"})
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_can_calculate_average_items_per_merchant
    assert_equal 2.88, sa.average_items_per_merchant
  end
end
