require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  attr_reader :sa

  def setup
    @sa = SalesAnalyst.from_csv({items: "./data/items.csv",
                            merchants: "./data/merchants.csv"})
  end

  def test_average_items
    assert_equal 2.88, sa.average_items_per_merchant
  end
end
