require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/sales_analyst'
require 'pry'

class SalesAnalystTest < MiniTest::Test

  def test_that_se_is_initialized
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    sa = SalesAnalyst.new(se)
    assert_instance_of SalesAnalyst, sa
  end






end
