require_relative 'test_helper'
require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  #note: not using fixtures. Consider update
  def test_it_exists
    se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv" })
    sa = SalesAnalyst.new(se)

    assert_instance_of SalesAnalyst, sa
  end  

  def test_that_average_items_per_merchant
    se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv" })
    sa = SalesAnalyst.new(se)

    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_that_average_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv({:items => "./data/items.csv", :merchants => "./data/merchants.csv" })
    sa = SalesAnalyst.new(se)

    assert_equal 3.18, sa.average_items_per_merchant_standard_deviation
  end

end