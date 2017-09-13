require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  attr_reader :sa, :se

  def setup
    @se = SalesEngine.from_csv({items: "./data/items.csv",
                            merchants: "./data/merchants.csv"})
    @sa = SalesAnalyst.new(@se)
  end

  def test_average_items
    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_standard_deviation
    assert_equal 3.26, sa.average_items_per_merchant_standard_deviation
  end
end
